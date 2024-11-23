import 'package:get/get.dart';

import '../../common/enums.dart';
import '../../common/snackbar.dart';
import '../../domain/entities/comic_detail_entity.dart';
import '../../domain/entities/user_comic_entity.dart';
import '../../domain/usecases/get_comic_detail_case.dart';
import '../../domain/usecases/user_comic_case.dart';
import '../../injection.dart';
import '../pages/login/login_page.dart';
import 'main_controller.dart';

class ComicDetailController extends GetxController {
  final GetComicDetailCase getComicDetailCase = locator();
  final UserComicCase userComicCase = locator();

  final MainController mainController = Get.find<MainController>();

  Rx<RequestState> stateComic = RequestState.empty.obs;
  Rx<RequestState> stateFavorite = RequestState.empty.obs;

  Rxn<DataComicDetailEntity> comic = Rxn();
  Rxn<UserComicEntity> userComic = Rxn();
  RxString path = "".obs;

  Future<void> initialize(String path) async {
    changePath(path);
    getComic(
      path: path,
    );
    getUserComic();
  }

  void changePath(String value) {
    path.value = value;
  }

  Future<void> getComic({required String path}) async {
    changeStateComic(RequestState.loading);
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

  Future<void> getUserComic() async {
    if (path.value.isEmpty) return;
    if (mainController.user.value == null) return;

    changeStateFavorite(RequestState.loading);
    final result = await userComicCase.getUserComicById(
      userId: mainController.user.value?.uid ?? "",
      id: path.value,
    );

    result.fold((l) {
      changeStateFavorite(RequestState.error);
    }, (r) {
      userComic.value = r;
      userComic.refresh();
      changeStateFavorite(RequestState.loaded);
    });
  }

  Future<void> setFavorite() async {
    if (path.value.isEmpty) return;
    if (mainController.user.value == null) {
      await Get.toNamed(LoginPage.routeName);

      await getUserComic();
    }

    if (mainController.user.value == null) return;

    changeStateFavorite(RequestState.loading);
    final result = await userComicCase.setUserComic(
      userId: mainController.user.value?.uid ?? "",
      userComic: UserComicEntity(
        id: path.value,
        comic: comic.value,
        isFavorite: !(userComic.value?.isFavorite ?? false),
      ),
    );

    result.fold((l) {
      changeStateFavorite(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      userComic.value = r;
      userComic.refresh();
      changeStateFavorite(RequestState.loaded);
    });
  }

  void changeStateComic(RequestState state) {
    stateComic.value = state;
    stateComic.refresh();
  }

  void changeStateFavorite(RequestState state) {
    stateFavorite.value = state;
    stateFavorite.refresh();
  }
}
