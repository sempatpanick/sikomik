import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/comic_detail_controller.dart';
import 'responsives/comic_detail_page_phone.dart';

class ComicDetailPage extends StatelessWidget {
  static const String routeName = "/:detail/:path";

  const ComicDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<ComicDetailController>(
      autoRemove: true,
      init: ComicDetailController(),
      initState: (state) => WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (Get.parameters['detail'] == null &&
              Get.parameters['path'] == null) {
            return;
          }
          state.controller.initialize(
            "/${Get.parameters['detail']!}/${Get.parameters['path']!}/",
          );
        },
      ),
      builder: (_) {
        // if (ResponsiveBreakpoints.of(context).isMobile) {
        if (size.width < 700) {
          return const ComicDetailPagePhone();
        }

        return const ComicDetailPagePhone();
      },
    );
  }
}
