import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/snackbar.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/manga_entity.dart';
import '../../domain/usecases/get_latest_manga_case.dart';
import '../../injection.dart';
import 'main_controller.dart';

class HomeController extends GetxController {
  final GetLatestMangaCase getLatestMangaCase = locator();

  Rx<RequestState> stateMangas = RequestState.loading.obs;

  final MainController mainController = Get.find<MainController>();

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchInputController = TextEditingController();

  RxList<DataMangaEntity> mangas = <DataMangaEntity>[].obs;
  RxInt currentPage = 0.obs;
  RxBool isLastPage = false.obs;

  @override
  void onInit() {
    scrollController.addListener(
      () {
        if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200) {
          if (stateMangas.value != RequestState.loading) {
            if (!isLastPage.value) {
              getLatestManga();
            }
          }
        }
      },
    );

    super.onInit();
  }

  Future<void> initialize() async {
    await mainController.getConfiguration();
    await getLatestManga(isClearMangas: true);
  }

  Future<void> getLatestManga({
    bool isClearMangas = false,
    bool isClearMangasSearch = false,
  }) async {
    changeStateMangas(RequestState.loading);

    if (isClearMangas) {
      mangas.clear();
      currentPage.value = 0;
      isLastPage.value = false;
    }

    final result = await getLatestMangaCase.execute(
        page: currentPage.value + 1, q: searchInputController.text);

    result.fold((l) {
      changeStateMangas(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      changeStateMangas(RequestState.loaded);
      currentPage.value = currentPage.value + 1;
      if ((r.data ?? []).isEmpty) {
        isLastPage.value = true;
      }
      mangas.addAll(r.data ?? []);
    });
  }

  void changeStateMangas(RequestState state) {
    stateMangas.value = state;
    stateMangas.refresh();
  }
}
