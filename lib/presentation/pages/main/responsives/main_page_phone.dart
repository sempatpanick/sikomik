import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/main_controller.dart';

class MainPagePhone extends StatelessWidget {
  const MainPagePhone({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<MainController>(
      builder: (controller) => Scaffold(
        body: controller.menus[controller.selectedIndexNav.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndexNav.value,
          type: BottomNavigationBarType.fixed,
          items: List.generate(
            controller.menus.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(
                controller.icons[index],
              ),
              label: controller.labels[index],
            ),
          ),
          onTap: controller.changeSelectedIndexNav,
        ),
      ),
    );
  }
}
