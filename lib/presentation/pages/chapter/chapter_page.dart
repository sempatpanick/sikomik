import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/chapter_controller.dart';
import 'responsives/chapter_page_phone.dart';

@RoutePage()
class ChapterPage extends StatelessWidget {
  static const String routeName = "/chapter:path";

  final String path;

  const ChapterPage({
    super.key,
    @PathParam('path') required this.path,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<ChapterController>(
      autoRemove: true,
      init: ChapterController(),
      didChangeDependencies: (state) => WidgetsBinding.instance.addPostFrameCallback(
        (_) => state.controller?.getChapter(path: path),
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
