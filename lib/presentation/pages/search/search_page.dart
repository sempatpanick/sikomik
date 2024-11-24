import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/search_comic_controller.dart';
import 'responsives/search_page_phone.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<SearchComicController>(
      autoRemove: true,
      init: SearchComicController(),
      builder: (_) {
        // if (ResponsiveBreakpoints.of(context).isMobile) {
        if (size.width < 700) {
          return const SearchPagePhone();
        }

        return const SearchPagePhone();
      },
    );
  }
}
