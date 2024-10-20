import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sikomik/common/theme.dart';

import '../../../../common/state_enum.dart';
import '../../../controllers/comic_detail_controller.dart';
import '../../chapter/chapter_page.dart';
import '../../main/main_page.dart';

class ComicDetailPagePhone extends StatelessWidget {
  const ComicDetailPagePhone({super.key});

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
            final isCanPop = await Navigator.of(context).maybePop();
            if (!isCanPop) {
              Get.offNamed(MainPage.routeName);
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
      body: GetX<ComicDetailController>(
        builder: (controller) =>
            controller.stateComic.value == RequestState.loading ||
                    controller.comic.value == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const ComicDetailPageContent(),
      ),
    );
  }
}

class ComicDetailPageContent extends StatelessWidget {
  const ComicDetailPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GetX<ComicDetailController>(
      builder: (controller) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: (controller.comic.value?.thumbnailUrl ?? "").isNotEmpty
                      ? Image(
                          image: kIsWeb || kIsWasm
                              ? CachedNetworkImageProvider(
                                  controller.comic.value!.thumbnailUrl!,
                                )
                              : NetworkImageWithRetry(
                                  controller.comic.value!.thumbnailUrl!,
                                ),
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, event) =>
                              event == null
                                  ? child
                                  : SizedBox(
                                      height: 140,
                                      child: Center(
                                        child: SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: CircularProgressIndicator(
                                            value: event.cumulativeBytesLoaded /
                                                (event.expectedTotalBytes ?? 1),
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
                        )
                      : const SizedBox(
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
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10.0),
                        ),
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
                            "${controller.comic.value?.rating ?? 0}",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating:
                                (controller.comic.value?.rating ?? 1) / 2,
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
                        controller.comic.value?.title ?? "",
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        controller.comic.value?.synopsis ?? "",
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
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10.0)),
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
                          children: [
                            TableRow(
                              children: [
                                Text(
                                  "Penulis",
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  controller.comic.value?.author ?? "",
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  "Tipe",
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  controller.comic.value?.type ?? "",
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  "Alur Cerita",
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  controller.comic.value?.storyConcept ?? "",
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text(
                                  "Status",
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  controller.comic.value?.status ?? "",
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1),
                        itemCount:
                            controller.comic.value?.chapters?.length ?? 0,
                        itemBuilder: (context, index) {
                          final item = controller.comic.value!.chapters![index];

                          return ListTile(
                            onTap: () {
                              if (item.path == null) return;
                              Get.toNamed(
                                ChapterPage.routeName.replaceAll(
                                  "/:detail/:chapter/:path",
                                  item.path!,
                                ),
                              );
                            },
                            title: Text(
                              "Chapter ${item.chapter}",
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              item.uploadedDate ?? "",
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
              child: (controller.comic.value?.imageUrl ?? "").isNotEmpty
                  ? Image(
                      image: kIsWeb || kIsWasm
                          ? CachedNetworkImageProvider(
                              controller.comic.value!.imageUrl!,
                            )
                          : NetworkImageWithRetry(
                              controller.comic.value!.imageUrl!,
                            ),
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
                                    value: event.cumulativeBytesLoaded /
                                        (event.expectedTotalBytes ?? 1),
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
                    )
                  : const SizedBox(
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
          ],
        ),
      ),
    );
  }
}
