import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/enums.dart';
import '../../common/snackbar.dart';
import '../../domain/entities/comic_entity.dart';
import '../../domain/usecases/get_latest_comic_case.dart';
import '../../domain/usecases/get_manga_comic_case.dart';
import '../../domain/usecases/get_manhua_comic_case.dart';
import '../../domain/usecases/get_manhwa_comic_case.dart';
import '../../domain/usecases/get_popular_comic_case.dart';
import '../../injection.dart';
import 'main_controller.dart';

class HomeController extends GetxController {
  final GetLatestComicCase getLatestComicCase = locator();
  final GetPopularComicCase getPopularComicCase = locator();
  final GetMangaComicCase getMangaComicCase = locator();
  final GetManhuaComicCase getManhuaComicCase = locator();
  final GetManhwaComicCase getManhwaComicCase = locator();

  Rx<RequestState> stateComics = RequestState.loading.obs;
  Rx<RequestState> stateComicsPopular = RequestState.loading.obs;
  Rx<RequestState> stateComicsManga = RequestState.loading.obs;
  Rx<RequestState> stateComicsManhua = RequestState.loading.obs;
  Rx<RequestState> stateComicsManhwa = RequestState.loading.obs;

  final MainController mainController = Get.find<MainController>();

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchInputController = TextEditingController();

  RxList<DataComicEntity> comics = <DataComicEntity>[].obs;
  RxList<DataComicEntity> comicsPopular = <DataComicEntity>[].obs;
  RxList<DataComicEntity> comicsManga = <DataComicEntity>[].obs;
  RxList<DataComicEntity> comicsManhua = <DataComicEntity>[].obs;
  RxList<DataComicEntity> comicsManhwa = <DataComicEntity>[].obs;
  RxInt currentPage = 0.obs;
  RxBool isLastPage = false.obs;

  Rx<ComicType> selectedComicType = ComicType.manga.obs;

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
    getLatestComics(isClearComics: true);
    getPopularComics();
    getMangaComics();
    getManhuaComics();
    getManhwaComics();
  }

  void changeSelectedComicType(ComicType? value) {
    selectedComicType.value = value ?? ComicType.manga;
    selectedComicType.refresh();
  }

  List<DataComicEntity> getComicsBasedOnSelectedType() {
    if (selectedComicType.value == ComicType.manga) {
      return comicsManga;
    }
    if (selectedComicType.value == ComicType.manhua) {
      return comicsManhua;
    }
    if (selectedComicType.value == ComicType.manhwa) {
      return comicsManhwa;
    }
    return [];
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
      page: currentPage.value + 1,
    );

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

  Future<void> getPopularComics() async {
    changeStateComicsPopular(RequestState.loading);

    final result = await getPopularComicCase.execute(
      page: 1,
    );

    result.fold((l) {
      changeStateComicsPopular(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      changeStateComicsPopular(RequestState.loaded);
      comicsPopular.assignAll(r.data ?? []);
    });
  }

  Future<void> getMangaComics() async {
    changeStateComicsManga(RequestState.loading);

    final result = await getMangaComicCase.execute(
      page: 1,
    );

    result.fold((l) {
      changeStateComicsManga(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      changeStateComicsManga(RequestState.loaded);
      comicsManga.assignAll(r.data ?? []);
    });
  }

  Future<void> getManhuaComics() async {
    changeStateComicsManhua(RequestState.loading);

    final result = await getManhuaComicCase.execute(
      page: 1,
    );

    result.fold((l) {
      changeStateComicsManhua(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      changeStateComicsManhua(RequestState.loaded);
      comicsManhua.assignAll(r.data ?? []);
    });
  }

  Future<void> getManhwaComics() async {
    changeStateComicsManhwa(RequestState.loading);

    final result = await getManhwaComicCase.execute(
      page: 1,
    );

    result.fold((l) {
      changeStateComicsManhwa(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      changeStateComicsManhwa(RequestState.loaded);
      comicsManhwa.assignAll(r.data ?? []);
    });
  }

  void changeStateComics(RequestState state) {
    stateComics.value = state;
    stateComics.refresh();
  }

  void changeStateComicsPopular(RequestState state) {
    stateComicsPopular.value = state;
    stateComicsPopular.refresh();
  }

  void changeStateComicsManga(RequestState state) {
    stateComicsManga.value = state;
    stateComicsManga.refresh();
  }

  void changeStateComicsManhua(RequestState state) {
    stateComicsManhua.value = state;
    stateComicsManhua.refresh();
  }

  void changeStateComicsManhwa(RequestState state) {
    stateComicsManhwa.value = state;
    stateComicsManhwa.refresh();
  }
}
