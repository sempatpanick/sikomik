import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/enums.dart';
import '../../domain/entities/user_comic_entity.dart';
import '../../domain/usecases/user_comic_case.dart';
import '../../injection.dart';
import 'main_controller.dart';

class FavoritesController extends GetxController {
  final UserComicCase userComicCase = locator();

  final MainController mainController = Get.find<MainController>();

  final ScrollController scrollController = ScrollController();

  Rx<RequestState> stateFavorites = RequestState.loading.obs;

  RxList<UserComicEntity> favorites = <UserComicEntity>[].obs;

  void initialize() {
    getFavorites();
  }

  Future<void> getFavorites() async {
    changeStateFavorites(RequestState.loading);
    if (mainController.user.value == null) {
      changeStateFavorites(RequestState.error);
    }

    final result = await userComicCase.getFavorites(
      userId: mainController.user.value?.uid ?? "",
    );

    result.fold((l) {
      changeStateFavorites(RequestState.error);
    }, (r) {
      favorites.assignAll(r.where((item) => item.comic != null));
      changeStateFavorites(RequestState.loaded);
    });
  }

  void changeStateFavorites(RequestState value) {
    stateFavorites.value = value;
    stateFavorites.refresh();
  }
}
