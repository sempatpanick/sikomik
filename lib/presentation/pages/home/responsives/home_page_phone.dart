import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/enums.dart';
import '../../../controllers/home_controller.dart';
import '../../../widgets/comic_card_widget.dart';

class HomePagePhone extends StatelessWidget {
  const HomePagePhone({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Komik Terbaru",
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GetX<HomeController>(
        builder: (controller) => RefreshIndicator(
          onRefresh: () => controller.searchInputController.text.isEmpty
              ? controller.getLatestComics(isClearComics: true)
              : controller.getLatestComics(isClearSearch: true),
          child: Scrollbar(
            controller: controller.scrollController,
            interactive: true,
            thumbVisibility: true,
            radius: Radius.circular(25),
            child: SingleChildScrollView(
              controller: controller.scrollController,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (size.width / 250).round(),
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        mainAxisExtent: 260,
                      ),
                      itemCount: controller.comics.length,
                      itemBuilder: (context, index) {
                        final item = controller.comics[index];

                        return ComicCardWidget(comic: item);
                      },
                    ),
                    if (controller.stateComics.value == RequestState.loading)
                      const SizedBox(
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
