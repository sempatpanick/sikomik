import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sikomik/common/theme.dart';

import '../../../../common/app_router.dart';
import '../../../../common/state_enum.dart';
import '../../../controllers/manga_detail_controller.dart';

class MangaDetailPagePhone extends StatelessWidget {
  const MangaDetailPagePhone({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () async {
            final autoRouter = AutoRouter.of(context);
            final isCanPop = await Navigator.of(context).maybePop();
            if (!isCanPop) {
              autoRouter.back();
            }
          },
          icon: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_back_outlined,
              color: theme.primaryColor,
            ),
          ),
        ),
      ),
      body: GetX<MangaDetailController>(
        builder: (controller) =>
            controller.stateManga.value == RequestState.loading || controller.manga.value == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const MangaDetailPageContent(),
      ),
    );
  }
}

class MangaDetailPageContent extends StatelessWidget {
  const MangaDetailPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GetX<MangaDetailController>(
      builder: (controller) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Image.network(
                    "${controller.mainController.configuration.value?.baseKomikUrl ?? ""}${controller.manga.value?.imagePath}",
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, event) => event == null
                        ? child
                        : SizedBox(
                            height: 140,
                            child: Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  value:
                                      event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                          ),
                    errorBuilder: (context, url, error) => const SizedBox(
                      height: 140,
                      child: Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 160.0, right: 24.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            offset: const Offset(1, 1),
                            blurRadius: 15.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Rating",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "${controller.manga.value?.rating ?? 0}",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: (controller.manga.value?.rating ?? 1) / 2,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            ignoreGestures: true,
                            glowColor: Colors.amber,
                            glowRadius: 10,
                            unratedColor: Colors.white,
                            itemSize: 20,
                            itemPadding: EdgeInsets.zero,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.manga.value?.title ?? "",
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        controller.manga.value?.description ?? "",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              offset: const Offset(1, 1),
                              blurRadius: 15.0,
                            ),
                          ],
                        ),
                        child: Table(
                          children: (controller.manga.value?.informations ?? [])
                              .map((item) => TableRow(children: [
                                    Text(
                                      item[0],
                                      style: theme.textTheme.labelLarge?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      item[1],
                                      style: theme.textTheme.labelLarge?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ]))
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        "Chapters",
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(height: 1),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => const Divider(height: 1),
                        itemCount: controller.manga.value?.chapters.length ?? 0,
                        itemBuilder: (context, index) {
                          final item = controller.manga.value!.chapters[index];

                          return ListTile(
                            onTap: () => context.router.push(ChapterRoute(path: item.path)),
                            title: Text(
                              "Chapter ${item.chapter}",
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              item.uploadAt,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 24.0,
              top: 110,
              child: Image.network(
                "${controller.mainController.configuration.value?.baseKomikUrl ?? ""}${controller.manga.value?.imagePath}",
                width: 130,
                height: 200,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, event) => event == null
                    ? child
                    : SizedBox(
                        width: 130,
                        height: 200,
                        child: Center(
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              value: event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                errorBuilder: (context, url, error) => const SizedBox(
                  width: 130,
                  height: 200,
                  child: Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
