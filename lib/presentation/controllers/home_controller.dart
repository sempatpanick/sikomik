import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/snackbar.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/comic_entity.dart';
import '../../domain/usecases/get_latest_comic_case.dart';
import '../../injection.dart';
import 'main_controller.dart';

class HomeController extends GetxController {
  final GetLatestComicCase getLatestComicCase = locator();

  Rx<RequestState> stateComics = RequestState.loading.obs;

  final MainController mainController = Get.find<MainController>();

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchInputController = TextEditingController();

  RxList<DataComicEntity> comics = <DataComicEntity>[].obs;
  RxInt currentPage = 0.obs;
  RxBool isLastPage = false.obs;

  @override
  void onInit() {
    scrollController.addListener(
      () {
        if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200) {
          if (stateComics.value != RequestState.loading) {
            if (!isLastPage.value) {
              getLatestComics();
            }
          }
        }
      },
    );

    super.onInit();
  }

  Future<void> initialize() async {
    await mainController.getConfiguration();
    await getLatestComics(isClearComics: true);
  }

  Future<void> getLatestComics({
    bool isClearComics = false,
    bool isClearSearch = false,
  }) async {
    changeStateComics(RequestState.loading);

    if (isClearComics) {
      comics.clear();
      currentPage.value = 0;
      isLastPage.value = false;
    }

    final result = await getLatestComicCase.execute(
        page: currentPage.value + 1, q: searchInputController.text);

    result.fold((l) {
      changeStateComics(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      changeStateComics(RequestState.loaded);
      currentPage.value = currentPage.value + 1;
      if ((r.data ?? []).isEmpty) {
        isLastPage.value = true;
      }
      comics.addAll(r.data ?? []);
    });
  }

  void changeStateComics(RequestState state) {
    stateComics.value = state;
    stateComics.refresh();
  }
}
