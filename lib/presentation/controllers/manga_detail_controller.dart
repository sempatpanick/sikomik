import 'package:get/get.dart';

import '../../common/snackbar.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/manga_detail_entity.dart';
import '../../domain/usecases/get_manga_detail_case.dart';
import '../../injection.dart';
import 'home_controller.dart';

class MangaDetailController extends GetxController {
  final GetMangaDetailCase getMangaDetailCase = locator();

  final HomeController homeController = Get.find<HomeController>();

  Rx<RequestState> stateManga = RequestState.empty.obs;

  Rxn<DataMangaDetailEntity> manga = Rxn();

  Future<void> getManga({required String path}) async {
    final result = await getMangaDetailCase.execute(path: path);

    result.fold((l) {
      changeStateManga(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      manga.value = r.data;
      manga.refresh();
      changeStateManga(RequestState.loaded);
    });
  }

  void changeStateManga(RequestState state) {
    stateManga.value = state;
    stateManga.refresh();
  }
}
