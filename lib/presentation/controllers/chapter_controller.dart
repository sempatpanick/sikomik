import 'package:get/get.dart';
import 'package:sikomik/common/snackbar.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/chapter_entity.dart';
import '../../domain/usecases/get_chapter_case.dart';
import '../../injection.dart';
import 'home_controller.dart';

class ChapterController extends GetxController {
  final GetChapterCase getChapterCase = locator();

  final HomeController homeController = Get.find<HomeController>();

  Rx<RequestState> stateChapter = RequestState.empty.obs;

  Rxn<DataChapterEntity> chapter = Rxn();

  Future<void> getChapter({required String path}) async {
    final result = await getChapterCase.execute(path: path);

    result.fold((l) {
      changeStateChapter(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      changeStateChapter(RequestState.loaded);
      chapter.value = r.data;
      chapter.refresh();
    });
  }

  void changeStateChapter(RequestState state) {
    stateChapter.value = state;
    stateChapter.refresh();
  }
}
