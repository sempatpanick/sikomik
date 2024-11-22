import 'package:get/get.dart';

import '../../common/enums.dart';
import '../../common/snackbar.dart';
import '../../domain/entities/chapter_entity.dart';
import '../../domain/entities/comic_detail_entity.dart';
import '../../domain/usecases/get_chapter_case.dart';
import '../../domain/usecases/get_comic_detail_case.dart';
import '../../injection.dart';
import '../pages/chapter/chapter_page.dart';

class ChapterController extends GetxController {
  final GetChapterCase getChapterCase = locator();
  final GetComicDetailCase getComicDetailCase = locator();

  Rx<RequestState> stateChapter = RequestState.empty.obs;
  Rx<RequestState> stateComicDetail = RequestState.empty.obs;

  Rxn<DataChapterEntity> chapter = Rxn();
  Rxn<DataComicDetailEntity> comic = Rxn();
  RxString path = "".obs;

  void changePath(String value) {
    path.value = value;
  }

  (bool state, String? path) isCanGoPreviousChapter() {
    final getIndex = comic.value?.chapters?.toList().indexWhere(
          (item) => item.chapter == chapter.value?.chapter,
        );

    if (getIndex == null || getIndex == -1) {
      return (false, null);
    }

    if (getIndex >= (comic.value?.chapters ?? []).length - 1) {
      return (false, null);
    }

    return (true, (comic.value?.chapters ?? [])[getIndex + 1].path);
  }

  (bool state, String? path) isCanGoNextChapter() {
    final getIndex = comic.value?.chapters?.indexWhere(
      (item) => item.chapter == chapter.value?.chapter,
    );

    if (getIndex == null || getIndex == -1) {
      return (false, null);
    }

    if (getIndex <= 0) {
      return (false, null);
    }

    return (true, (comic.value?.chapters ?? [])[getIndex - 1].path);
  }

  void goPreviousChapter() {
    final data = isCanGoPreviousChapter();
    if (!data.$1) return;
    if (data.$2 == null) return;

    Get.offNamed(
      ChapterPage.routeName.replaceAll(
        "/:detail/:chapter/:path",
        data.$2!,
      ),
    );
  }

  void goNextChapter() {
    final data = isCanGoNextChapter();
    if (!data.$1) return;
    if (data.$2 == null) return;

    Get.offNamed(
      ChapterPage.routeName.replaceAll(
        "/:detail/:chapter/:path",
        data.$2!,
      ),
    );
  }

  void refreshChapter() {
    getChapter(path: path.value);
  }

  Future<void> getChapter({required String path}) async {
    chapter.value = null;
    chapter.refresh();
    final result = await getChapterCase.execute(path: path);

    result.fold((l) {
      changeStateChapter(RequestState.error);
      failedSnackBar("", l.message);
      chapter.value = null;
      chapter.refresh();
    }, (r) {
      changeStateChapter(RequestState.loaded);
      chapter.value = r.data;
      chapter.refresh();
      getComicDetail();
    });
  }

  Future<void> getComicDetail() async {
    if (chapter.value?.comicPath == null) {
      return;
    }

    final result = await getComicDetailCase.execute(
      path: chapter.value?.comicPath ?? "",
    );

    result.fold((l) {
      changeStateComicDetail(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      comic.value = r.data;
      comic.refresh();
      changeStateComicDetail(RequestState.loaded);
    });
  }

  void changeStateChapter(RequestState state) {
    stateChapter.value = state;
    stateChapter.refresh();
  }

  void changeStateComicDetail(RequestState state) {
    stateComicDetail.value = state;
    stateComicDetail.refresh();
  }
}
