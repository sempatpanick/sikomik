import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/enums.dart';
import '../../common/snackbar.dart';
import '../../domain/entities/comic_entity.dart';
import '../../domain/usecases/search_comic_case.dart';
import '../../injection.dart';
import 'main_controller.dart';

class SearchComicController extends GetxController {
  final SearchComicCase searchComicCase = locator();

  final mainController = Get.find<MainController>();

  final ScrollController scrollController = ScrollController();

  final TextEditingController searchInputController = TextEditingController();

  Rx<RequestState> stateSearch = RequestState.empty.obs;

  RxString query = "".obs;
  RxList<DataComicEntity> comics = <DataComicEntity>[].obs;

  void changeQuery(String value) {
    query.value = value;
  }

  void clearQuery() {
    searchInputController.clear();
    query.value = "";
    changeStateSearch(RequestState.empty);
  }

  Future<void> search() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (searchInputController.text.isEmpty) {
      clearQuery();
      return;
    }

    if (searchInputController.text.length < 3) {
      failedSnackBar(
        "Failed",
        "Please input minimum 3 characters",
      );
      return;
    }

    changeStateSearch(RequestState.loading);
    final result = await searchComicCase.execute(
      query: searchInputController.text,
    );

    result.fold((l) {
      changeStateSearch(RequestState.error);
      failedSnackBar("Failed", l.message);
    }, (r) {
      comics.assignAll(r.data ?? []);
      changeStateSearch(RequestState.loaded);
    });
  }

  void changeStateSearch(RequestState value) {
    stateSearch.value = value;
    stateSearch.refresh();
  }
}
