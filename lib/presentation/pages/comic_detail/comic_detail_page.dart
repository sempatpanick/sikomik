import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/comic_detail_controller.dart';
import 'responsives/comic_detail_page_phone.dart';

@RoutePage()
class ComicDetailPage extends StatelessWidget {
  static const String routeName = "/chapter:path";

  final String path;

  const ComicDetailPage({
    super.key,
    @PathParam('path') required this.path,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<ComicDetailController>(
      autoRemove: true,
      init: ComicDetailController(),
      didChangeDependencies: (state) =>
          WidgetsBinding.instance.addPostFrameCallback(
        (_) => state.controller?.getComic(path: path),
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
