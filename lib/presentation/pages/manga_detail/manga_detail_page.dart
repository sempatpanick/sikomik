import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/manga_detail_controller.dart';
import 'responsives/manga_detail_page_phone.dart';

@RoutePage()
class MangaDetailPage extends StatelessWidget {
  static const String routeName = "/chapter:path";

  final String path;

  const MangaDetailPage({
    super.key,
    @PathParam('path') required this.path,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<MangaDetailController>(
      autoRemove: true,
      init: MangaDetailController(),
      didChangeDependencies: (state) => WidgetsBinding.instance.addPostFrameCallback(
        (_) => state.controller?.getManga(path: path),
      ),
      builder: (_) {
        // if (ResponsiveBreakpoints.of(context).isMobile) {
        if (size.width < 700) {
          return const MangaDetailPagePhone();
        }

        return const MangaDetailPagePhone();
      },
    );
  }
}
