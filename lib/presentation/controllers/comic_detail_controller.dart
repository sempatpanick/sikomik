import 'package:get/get.dart';

import '../../common/snackbar.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/comic_detail_entity.dart';
import '../../domain/usecases/get_comic_detail_case.dart';
import '../../injection.dart';
import 'main_controller.dart';

class ComicDetailController extends GetxController {
  final GetComicDetailCase getComicDetailCase = locator();

  final MainController mainController = Get.find<MainController>();

  Rx<RequestState> stateComic = RequestState.empty.obs;

  Rxn<DataComicDetailEntity> comic = Rxn();

  Future<void> getComic({required String path}) async {
    final result = await getComicDetailCase.execute(path: path);

    result.fold((l) {
      changeStateComic(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      comic.value = r.data;
      comic.refresh();
      changeStateComic(RequestState.loaded);
    });
  }

  void changeStateComic(RequestState state) {
    stateComic.value = state;
    stateComic.refresh();
  }
}
