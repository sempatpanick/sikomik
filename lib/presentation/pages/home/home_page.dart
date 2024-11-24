import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import 'responsives/home_page_phone.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<HomeController>(
      autoRemove: true,
      init: HomeController(),
      initState: (state) => WidgetsBinding.instance.addPostFrameCallback(
        (_) => state.controller.initialize(),
      ),
      builder: (_) {
        // if (ResponsiveBreakpoints.of(context).isMobile) {
        if (size.width < 700) {
          return const HomePagePhone();
        }

        return const HomePagePhone();
      },
    );
  }
}
