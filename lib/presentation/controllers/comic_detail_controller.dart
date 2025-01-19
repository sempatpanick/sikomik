import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/enums.dart';
import '../../common/snackbar.dart';
import '../../domain/entities/comic_detail_entity.dart';
import '../../domain/entities/user_comic_chapter_entity.dart';
import '../../domain/entities/user_comic_entity.dart';
import '../../domain/usecases/get_comic_detail_case.dart';
import '../../domain/usecases/user_comic_case.dart';
import '../../domain/usecases/user_comic_chapter_case.dart';
import '../../injection.dart';
import '../pages/login/login_page.dart';
import 'main_controller.dart';

class ComicDetailController extends GetxController {
  final GetComicDetailCase getComicDetailCase = locator();
  final UserComicCase userComicCase = locator();
  final UserComicChapterCase userComicChapterCase = locator();

  final MainController mainController = Get.find<MainController>();

  final ScrollController scrollController = ScrollController();

  Rx<RequestState> stateComic = RequestState.empty.obs;
  Rx<RequestState> stateUserComic = RequestState.empty.obs;
  Rx<RequestState> stateUserComicChaptersRead = RequestState.empty.obs;
  Rx<RequestState> stateFavorite = RequestState.empty.obs;

  Rxn<DataComicDetailEntity> comic = Rxn();
  Rxn<UserComicEntity> userComic = Rxn();
  RxList<UserComicChapterEntity> userComicChaptersRead =
      <UserComicChapterEntity>[].obs;
  RxString path = "".obs;

  Future<void> initialize(String path) async {
    changePath(path);
    getComic(
      path: path,
    );
    getUserComicChaptersRead();
    await getUserComic();
    // migrationChaptersRead();
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
    if (mainController.user.value == null) {
      await retryCheckUserId();

      if (mainController.user.value == null) return;
    }

    changeStateUserComic(RequestState.loading);
    final result = await userComicCase.getUserComicById(
      userId: mainController.user.value?.uid ?? "",
      id: path.value,
    );

    result.fold((l) {
      changeStateUserComic(RequestState.error);
    }, (r) {
      userComic.value = r;
      userComic.refresh();
      changeStateUserComic(RequestState.loaded);
    });
  }

  Future<void> getUserComicChaptersRead() async {
    if (path.value.isEmpty) return;
    if (mainController.user.value == null) {
      await retryCheckUserId();

      if (mainController.user.value == null) return;
    }

    changeStateUserComicChaptersRead(RequestState.loading);
    final result = await userComicChapterCase.getUserComicChaptersRead(
      userId: mainController.user.value?.uid ?? "",
      userComicId: path.value,
    );

    result.fold((l) {
      changeStateUserComicChaptersRead(RequestState.error);
    }, (r) {
      userComicChaptersRead.assignAll(r);
      userComic.refresh();
      changeStateUserComicChaptersRead(RequestState.loaded);
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
      data: UserComicEntity(
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

  // Future<void> migrationChaptersRead() async {
  //   if ((userComic.value?.readChapters ?? []).isEmpty) {
  //     return;
  //   }
  //
  //   final result = await userComicChapterCase.setBatchUserComicChapterRead(
  //     userId: mainController.user.value?.uid ?? "",
  //     data: userComic.value?.readChapters
  //             ?.map(
  //               (item) => UserComicChapterEntity(
  //                 id: item.path,
  //                 chapter: item,
  //               ),
  //             )
  //             .toList() ??
  //         [],
  //   );
  //
  //   result.fold((l) {}, (r) {
  //     userComicCase.setUserComic(
  //       userId: mainController.user.value?.uid ?? "",
  //       data: UserComicEntity(
  //         id: path.value,
  //         readChapters: [],
  //       ),
  //     );
  //   });
  // }

  Future<void> retryCheckUserId() async {
    int count = 3;
    while (mainController.user.value == null && count > 0) {
      await Future.delayed(Duration(seconds: 1));
      count--;
    }
  }

  void changeStateComic(RequestState state) {
    stateComic.value = state;
    stateComic.refresh();
  }

  void changeStateUserComic(RequestState state) {
    stateUserComic.value = state;
    stateUserComic.refresh();
  }

  void changeStateUserComicChaptersRead(RequestState state) {
    stateUserComicChaptersRead.value = state;
    stateUserComicChaptersRead.refresh();
  }

  void changeStateFavorite(RequestState state) {
    stateFavorite.value = state;
    stateFavorite.refresh();
  }
}
