import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikomik/common/snackbar.dart';

import '../../common/enums.dart';
import '../../domain/entities/configuration_entity.dart';
import '../../domain/usecases/authentication_case.dart';
import '../../domain/usecases/get_configuration_case.dart';
import '../../injection.dart';
import '../pages/home/home_page.dart';
import '../pages/settings/settings_page.dart';

class MainController extends GetxController {
  final AuthenticationCase authenticationCase = locator();
  final GetConfigurationCase getConfigurationCase = locator();

  RxInt selectedIndexNav = 0.obs;
  Rxn<ConfigurationEntity> configuration = Rxn();
  Rxn<User> user = Rxn();

  Rx<RequestState> loadingLogoutState = RequestState.empty.obs;

  List<Widget> menus = [
    const HomePage(),
    const SettingsPage(),
  ];
  List<IconData> icons = [
    Icons.home,
    Icons.settings,
  ];
  List<String> labels = [
    "Home",
    "Settings",
  ];

  void initialize() {
    if (Get.arguments is int) {
      changeSelectedIndexNav(Get.arguments);
    }
    getConfiguration();
    getUser();
  }

  void changeSelectedIndexNav(int index) {
    selectedIndexNav.value = index;
  }

  Future<void> getConfiguration() async {
    final result = await getConfigurationCase.execute();

    result.fold((l) {
      configuration.value = null;
      configuration.refresh();
    }, (r) {
      configuration.value = r;
      configuration.refresh();
    });
  }

  Future<void> getUser() async {
    final result = await authenticationCase.getUser();

    result.fold((l) {
      failedSnackBar(
        "Failed",
        l.message,
      );
    }, (r) {
      user.value = r;
      user.refresh();
    });
  }

  Future<void> logout() async {
    changeLoadingLogoutState(RequestState.loading);
    final result = await authenticationCase.logout();

    result.fold((l) {
      changeLoadingLogoutState(RequestState.error);
      failedSnackBar("Failed", l.message);
    }, (r) {
      changeLoadingLogoutState(RequestState.loaded);
      successSnackBar("Success", "Logout successfully");
      getUser();
    });
  }

  void changeLoadingLogoutState(RequestState state) {
    loadingLogoutState.value = state;
    loadingLogoutState.refresh();
  }
}
