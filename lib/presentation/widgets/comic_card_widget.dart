import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../domain/entities/comic_entity.dart';
import '../pages/comic_detail/comic_detail_page.dart';

class ComicCardWidget extends StatelessWidget {
  final DataComicEntity comic;

  const ComicCardWidget({
    super.key,
    required this.comic,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return InkWell(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10.0)),
      onTap: () {
        if (comic.path == null) return;
        Get.toNamed(
          ComicDetailPage.routeName.replaceFirst(
            "/:detail/:path",
            comic.path!,
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              blurStyle: BlurStyle.outer,
              blurRadius: 20.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ((comic.imageUrl ?? "").isNotEmpty)
              Image(
                image: kIsWeb || kIsWasm
                    ? CachedNetworkImageProvider(
                        comic.imageUrl!,
                      )
                    : NetworkImageWithRetry(
                        comic.imageUrl!,
                      ),
                width: double.infinity,
                height: 140,
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
              ),
            if ((comic.imageUrl ?? "").isEmpty)
              const SizedBox(
                height: 140,
                child: Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
              ),
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                comic.title ?? "",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chapter ${comic.chapter}",
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RatingBar.builder(
                          initialRating: (comic.rating ?? 0) / 2,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          glowColor: Colors.amber,
                          glowRadius: 10,
                          unratedColor: Colors.white,
                          itemSize: 12,
                          itemPadding: EdgeInsets.zero,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                      ),
                      Text(
                        "${comic.rating}",
                        style: theme.textTheme.labelMedium?.copyWith(
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
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
