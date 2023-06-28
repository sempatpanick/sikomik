import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/configuration_entity.dart';
import '../../domain/usecases/get_configuration_case.dart';
import '../../injection.dart';
import '../pages/home/home_page.dart';
import '../pages/settings/settings_page.dart';

class MainController extends GetxController {
  final GetConfigurationCase getConfigurationCase = locator();

  RxInt selectedIndexNav = 0.obs;
  Rxn<ConfigurationEntity> configuration = Rxn();

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
}
