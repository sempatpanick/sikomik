import 'package:get/get.dart';

import '../../common/enums.dart';
import '../../common/snackbar.dart';
import '../../domain/entities/chapter_entity.dart';
import '../../domain/entities/comic_detail_entity.dart';
import '../../domain/entities/user_comic_entity.dart';
import '../../domain/usecases/get_chapter_case.dart';
import '../../domain/usecases/get_comic_detail_case.dart';
import '../../domain/usecases/user_comic_case.dart';
import '../../injection.dart';
import '../pages/chapter/chapter_page.dart';
import 'main_controller.dart';

class ChapterController extends GetxController {
  final GetChapterCase getChapterCase = locator();
  final GetComicDetailCase getComicDetailCase = locator();
  final UserComicCase userComicCase = locator();

  final mainController = Get.find<MainController>();

  Rx<RequestState> stateChapter = RequestState.empty.obs;
  Rx<RequestState> stateComicDetail = RequestState.empty.obs;

  Rxn<DataChapterEntity> chapter = Rxn();
  Rxn<DataComicDetailEntity> comic = Rxn();
  Rxn<UserComicEntity> userComic = Rxn();
  RxString path = "".obs;

  Future<void> initialize(String path) async {
    changePath(path);
    await getChapter(
      path: path,
    );
    await getUserComic();
    await setLastReadComic();
  }

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

  Future<void> getUserComic() async {
    if (chapter.value?.comicPath == null) return;
    if (mainController.user.value == null) {
      if (mainController.user.value == null) {
        await retryCheckUserId();

        if (mainController.user.value == null) return;
      }
    }

    final result = await userComicCase.getUserComicById(
      userId: mainController.user.value?.uid ?? "",
      id: chapter.value?.comicPath ?? "",
    );

    result.fold((l) {}, (r) {
      userComic.value = r;
      userComic.refresh();
    });
  }

  Future<void> setLastReadComic() async {
    if (chapter.value?.comicPath == null) return;
    if (mainController.user.value == null) {
      if (mainController.user.value == null) {
        await retryCheckUserId();

        if (mainController.user.value == null) return;
      }
    }

    final readChapters = List<DataChapterEntity>.of(
      userComic.value?.readChapters ?? [],
    );

    final getIndexChapter = readChapters
        .indexWhere((item) => item.chapter == chapter.value?.chapter);

    if (getIndexChapter == -1) {
      readChapters.add(chapter.value!);
    } else {
      readChapters[getIndexChapter] = chapter.value!;
    }

    await userComicCase.setUserComic(
      userId: mainController.user.value?.uid ?? "",
      userComic: UserComicEntity(
        id: chapter.value?.comicPath,
        comic: comic.value,
        readChapters: readChapters,
        lastReadChapter: chapter.value,
      ),
    );
  }

  Future<void> retryCheckUserId() async {
    int count = 3;
    while (mainController.user.value == null && count > 0) {
      await Future.delayed(Duration(seconds: 1));
      count--;
    }
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
