import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:get/get.dart';

import '../../../../common/enums.dart';
import '../../../../common/theme.dart';
import '../../../controllers/chapter_controller.dart';
import '../../comic_detail/comic_detail_page.dart';
import '../../main/main_page.dart';

class ChapterPagePhone extends StatelessWidget {
  const ChapterPagePhone({super.key});

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
        leading: GetBuilder<ChapterController>(
          builder: (controller) => IconButton(
            onPressed: () async {
              final isCanPop = await Navigator.of(context).maybePop();
              if (!isCanPop) {
                if (controller.chapter.value?.comicPath == null) {
                  Get.offAllNamed(
                    MainPage.routeName,
                  );
                  return;
                }
                Get.offNamed(
                  ComicDetailPage.routeName.replaceFirst(
                    "/:detail/:path",
                    controller.chapter.value!.comicPath!,
                  ),
                );
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
      ),
      body: GetX<ChapterController>(
        builder: (controller) => controller.stateChapter.value ==
                    RequestState.loading ||
                controller.chapter.value == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  InteractiveViewer(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: controller.chapter.value?.images?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (controller.chapter.value?.images == null) {
                          return SizedBox();
                        }

                        final item = controller.chapter.value!.images![index];

                        return Image(
                          image: kIsWeb || kIsWasm
                              ? NetworkImage(item)
                              : NetworkImageWithRetry(item),
                          fit: BoxFit.fill,
                          frameBuilder: (context, child, value, state) {
                            if (value == null) {
                              return SizedBox(
                                width: double.infinity,
                                height: 100,
                                child: Center(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return child;
                          },
                          loadingBuilder: (context, child, event) =>
                              event == null
                                  ? child
                                  : SizedBox(
                                      width: double.infinity,
                                      height: 100,
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
                            width: double.infinity,
                            height: 100,
                            child: Center(
                              child: Icon(
                                Icons.broken_image_outlined,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (controller.stateComicDetail.value != RequestState.loading)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        children: [
                          Expanded(
                            child: !controller.isCanGoPreviousChapter().$1
                                ? SizedBox()
                                : ElevatedButton.icon(
                                    onPressed: controller.goPreviousChapter,
                                    icon: Icon(
                                      Icons.arrow_circle_left_outlined,
                                    ),
                                    label: Text(
                                      "Previous",
                                    ),
                                  ).fadeIn(
                                    duration: Duration(seconds: 1),
                                  ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          IconButton(
                            onPressed: controller.refreshChapter,
                            style: IconButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                            ),
                            icon: Icon(Icons.refresh),
                          ).fadeIn(
                            duration: Duration(seconds: 1),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: !controller.isCanGoNextChapter().$1
                                ? SizedBox()
                                : ElevatedButton.icon(
                                    onPressed: controller.goNextChapter,
                                    icon: Icon(
                                      Icons.arrow_circle_right_outlined,
                                    ),
                                    iconAlignment: IconAlignment.end,
                                    label: Text(
                                      "Next",
                                    ),
                                  ).fadeIn(
                                    duration: Duration(seconds: 1),
                                  ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
