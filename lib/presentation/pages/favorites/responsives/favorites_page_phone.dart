import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/enums.dart';
import '../../../controllers/favorites_controller.dart';
import '../../../widgets/comic_favorite_card_widget.dart';

class FavoritesPagePhone extends StatelessWidget {
  const FavoritesPagePhone({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Komik Favorite",
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GetX<FavoritesController>(
        builder: (controller) => RefreshIndicator(
          onRefresh: controller.getFavorites,
          child: Scrollbar(
            controller: controller.scrollController,
            interactive: true,
            thumbVisibility: true,
            radius: Radius.circular(25),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  children: [
                    if (controller.favorites.isEmpty)
                      Center(
                        child: Text(
                          "Anda belum menambahkan komik ke daftar favorite",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    if (controller.favorites.isNotEmpty)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (size.width / 250).round(),
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          mainAxisExtent: 260,
                        ),
                        itemCount: controller.favorites.length,
                        itemBuilder: (context, index) {
                          final item = controller.favorites[index];

                          return ComicFavoriteCardWidget(
                            userComic: item,
                            afterCloseComic: controller.getFavorites,
                          );
                        },
                      ),
                    if (controller.stateFavorites.value == RequestState.loading)
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
