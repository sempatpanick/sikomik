import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../common/app_router.gr.dart';
import '../../domain/entities/manga_entity.dart';

class MangaCardWidget extends StatelessWidget {
  final DataMangaEntity manga;

  const MangaCardWidget({
    super.key,
    required this.manga,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return InkWell(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10.0)),
      onTap: () {
        if (manga.path == null) return;
        context.router.push(MangaDetailRoute(path: manga.path!));
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(10.0)),
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
            if (manga.imageUrl != null)
              Image.network(
                "${manga.imageUrl}",
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
            if (manga.imageUrl == null)
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
                manga.title ?? "",
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
                    "Chapter ${manga.chapter}",
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
                          initialRating: (manga.rating ?? 0) / 2,
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
                        "${manga.rating}",
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
