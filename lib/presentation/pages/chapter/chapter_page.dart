import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/chapter_controller.dart';
import 'responsives/chapter_page_phone.dart';

class ChapterPage extends StatelessWidget {
  static const String routeName = "/:detail/:chapter/:path";

  const ChapterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<ChapterController>(
      autoRemove: true,
      init: ChapterController(),
      initState: (state) => WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (Get.parameters['path'] == null) return;
          state.controller.initialize(
            "/${Get.parameters['detail']!}/${Get.parameters['chapter']!}/${Get.parameters['path']!}/",
          );
        },
      ),
      builder: (_) {
        // if (ResponsiveBreakpoints.of(context).isMobile) {
        if (size.width < 700) {
          return const ChapterPagePhone();
        }

        return const ChapterPagePhone();
      },
    );
  }
}
