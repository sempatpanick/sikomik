import 'package:get/get.dart';

import '../../common/snackbar.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/manga_detail_entity.dart';
import '../../domain/usecases/get_manga_detail_case.dart';
import '../../injection.dart';

class MangaDetailController extends GetxController {
  final GetMangaDetailCase getMangaDetailCase = locator();

  Rx<RequestState> stateManga = RequestState.empty.obs;

  Rxn<DataMangaDetailEntity> manga = Rxn();

  Future<void> getManga({required String path}) async {
    final result = await getMangaDetailCase.execute(path: path);

    result.fold((l) {
      changeStateManga(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      changeStateManga(RequestState.loaded);
      manga.value = r.data;
      manga.refresh();
    });
  }

  void changeStateManga(RequestState state) {
    stateManga.value = state;
    stateManga.refresh();
  }
}
