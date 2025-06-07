import 'package:flutter/cupertino.dart';
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
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 24.0,
                    horizontal: 16.0,
                  ),
                  constraints: BoxConstraints(maxWidth: 900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Komik Terpopuler",
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 230,
                        child: controller.stateComicsPopular.value ==
                                RequestState.loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 8,
                                ),
                                itemCount: controller.comicsPopular.length,
                                itemBuilder: (context, index) {
                                  final item = controller.comicsPopular[index];

                                  return SizedBox(
                                    width: 150,
                                    child: ComicCardWidget(
                                      comic: item,
                                      isExpandedWidth: false,
                                    ),
                                  );
                                },
                              ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Komik Terbaru",
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoSlidingSegmentedControl(
                            backgroundColor: theme.cardColor,
                            proportionalWidth: true,
                            thumbColor: theme.primaryColor,
                            groupValue: controller.selectedComicType.value,
                            children: {
                              ComicType.manga: Text(
                                "Manga",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: controller.selectedComicType.value ==
                                          ComicType.manga
                                      ? Colors.white
                                      : theme.primaryColor,
                                ),
                              ),
                              ComicType.manhua: Text(
                                "Manhua",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: controller.selectedComicType.value ==
                                          ComicType.manhua
                                      ? Colors.white
                                      : theme.primaryColor,
                                ),
                              ),
                              ComicType.manhwa: Text(
                                "Manhwa",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: controller.selectedComicType.value ==
                                          ComicType.manhwa
                                      ? Colors.white
                                      : theme.primaryColor,
                                ),
                              ),
                            },
                            onValueChanged: controller.changeSelectedComicType,
                          ),
                          // TextButton(
                          //   onPressed: () {},
                          //   child: Text(
                          //     "Lihat Semua",
                          //     style: theme.textTheme.labelLarge?.copyWith(
                          //       color: Colors.white,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 260,
                        child: (controller.selectedComicType.value ==
                                        ComicType.manga &&
                                    controller.stateComicsManga.value ==
                                        RequestState.loading) ||
                                (controller.selectedComicType.value ==
                                        ComicType.manhua &&
                                    controller.stateComicsManhua.value ==
                                        RequestState.loading) ||
                                (controller.selectedComicType.value ==
                                        ComicType.manhwa &&
                                    controller.stateComicsManhwa.value ==
                                        RequestState.loading)
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 8,
                                ),
                                itemCount: controller
                                    .getComicsBasedOnSelectedType()
                                    .length,
                                itemBuilder: (context, index) {
                                  final item = controller
                                      .getComicsBasedOnSelectedType()[index];

                                  return SizedBox(
                                    width: 150,
                                    child: ComicCardWidget(
                                      comic: item,
                                      isExpandedWidth: false,
                                    ),
                                  );
                                },
                              ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Semua Komik Terbaru",
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (size.width / 250).round() <= 5
                              ? (size.width / 250).round()
                              : 5,
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
      ),
    );
  }
}
