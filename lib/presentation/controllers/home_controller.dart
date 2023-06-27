import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikomik/common/snackbar.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/manga_entity.dart';
import '../../domain/usecases/get_latest_manga_case.dart';
import '../../injection.dart';

class HomeController extends GetxController {
  final GetLatestMangaCase getLatestMangaCase = locator();

  Rx<RequestState> stateMangas = RequestState.loading.obs;

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchInputController = TextEditingController();

  RxList<DataMangaEntity> mangas = <DataMangaEntity>[].obs;
  RxInt currentPage = 0.obs;
  RxInt maxPage = 0.obs;

  RxList<DataMangaEntity> mangasSearch = <DataMangaEntity>[].obs;
  RxInt currentPageSearch = 0.obs;
  RxInt maxPageSearch = 0.obs;

  @override
  void onInit() {
    scrollController.addListener(
      () {
        if (scrollController.offset > scrollController.position.maxScrollExtent - 200) {
          if (stateMangas.value != RequestState.loading) {
            if (!(currentPage.value == maxPage.value)) {
              getLatestManga();
            }
          }
        }
      },
    );

    super.onInit();
  }

  Future<void> getLatestManga({
    bool isClearMangas = false,
    bool isClearMangasSearch = false,
  }) async {
    changeStateMangas(RequestState.loading);

    if (isClearMangas) {
      mangas.clear();
    }
    if (isClearMangasSearch) {
      mangasSearch.clear();
    }

    final result = await getLatestMangaCase.execute(
        page: currentPage.value + 1, q: searchInputController.text);

    result.fold((l) {
      changeStateMangas(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      changeStateMangas(RequestState.loaded);
      if (searchInputController.text.isEmpty) {
        currentPage.value = r.page;
        maxPage.value = r.maxPage;
        mangas.addAll(r.data);
      } else {
        currentPageSearch.value = r.page;
        maxPageSearch.value = r.maxPage;
        mangasSearch.addAll(r.data);
      }
    });
  }

  void changeStateMangas(RequestState state) {
    stateMangas.value = state;
    stateMangas.refresh();
  }
}
