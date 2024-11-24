import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/favorites_controller.dart';
import 'responsives/favorites_page_phone.dart';

class FavoritesPage extends StatelessWidget {
  static const String routeName = "/favorites";

  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<FavoritesController>(
      autoRemove: true,
      init: FavoritesController(),
      initState: (state) => WidgetsBinding.instance.addPostFrameCallback(
        (_) => state.controller.initialize(),
      ),
      builder: (_) {
        // if (ResponsiveBreakpoints.of(context).isMobile) {
        if (size.width < 700) {
          return const FavoritesPagePhone();
        }

        return const FavoritesPagePhone();
      },
    );
  }
}
