import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main_controller.dart';
import 'responsives/main_page_phone.dart';

class MainPage extends StatelessWidget {
  static const String routeName = "/";

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<MainController>(
      autoRemove: true,
      init: MainController(),
      didChangeDependencies: (state) =>
          WidgetsBinding.instance.addPostFrameCallback(
        (_) => state.controller?.getConfiguration(),
      ),
      builder: (_) {
        // if (ResponsiveBreakpoints.of(context).isMobile) {
        if (size.width < 700) {
          return const MainPagePhone();
        }

        return const MainPagePhone();
      },
    );
  }
}
