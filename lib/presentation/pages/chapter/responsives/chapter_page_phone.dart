import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/enums.dart';
import '../../../controllers/chapter_controller.dart';
import '../../comic_detail/comic_detail_page.dart';
import '../../main/main_page.dart';

class ChapterPagePhone extends StatelessWidget {
  const ChapterPagePhone({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: GetX<ChapterController>(
        builder: (controller) => Stack(
          children: [
            controller.stateChapter.value == RequestState.loading ||
                    controller.chapter.value == null
                ? SizedBox(
                    width: size.width,
                    height: size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Scrollbar(
                    controller: controller.scrollController,
                    interactive: true,
                    thumbVisibility: true,
                    radius: Radius.circular(25),
                    child: SingleChildScrollView(
                      controller: controller.scrollController,
                      physics: BouncingScrollPhysics(),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 900),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount:
                                controller.chapter.value?.images?.length ?? 0,
                            itemBuilder: (context, index) {
                              final item =
                                  controller.chapter.value!.images![index];

                              return InkWell(
                                onTap: () => Get.dialog(
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SingleChildScrollView(
                                        child: InteractiveViewer(
                                          child: Image(
                                            image: NetworkImage(
                                              item,
                                              webHtmlElementStrategy:
                                                  WebHtmlElementStrategy
                                                      .fallback,
                                            ),
                                            fit: BoxFit.fill,
                                            frameBuilder:
                                                (context, child, value, state) {
                                              if (value == null) {
                                                return SizedBox(
                                                  width: double.infinity,
                                                  height: 100,
                                                  child: Center(
                                                    child: SizedBox(
                                                      width: 40,
                                                      height: 40,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color:
                                                            theme.primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              return child;
                                            },
                                            loadingBuilder: (context, child,
                                                    event) =>
                                                event == null
                                                    ? child
                                                    : SizedBox(
                                                        width: double.infinity,
                                                        height: 100,
                                                        child: Center(
                                                          child: SizedBox(
                                                            width: 40,
                                                            height: 40,
                                                            child:
                                                                CircularProgressIndicator(
                                                              value: event
                                                                      .cumulativeBytesLoaded /
                                                                  (event.expectedTotalBytes ??
                                                                      1),
                                                              color: theme
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                            errorBuilder:
                                                (context, url, error) =>
                                                    const SizedBox(
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
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          onPressed: Get.back,
                                          color: Colors.white,
                                          icon: Icon(
                                            Icons.close,
                                            size: 30,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                child: Image(
                                  image: NetworkImage(
                                    item,
                                    webHtmlElementStrategy:
                                        WebHtmlElementStrategy.fallback,
                                  ),
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
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: event
                                                            .cumulativeBytesLoaded /
                                                        (event.expectedTotalBytes ??
                                                            1),
                                                    color: theme.primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                  errorBuilder: (context, url, error) =>
                                      const SizedBox(
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
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
            Positioned(
              key: controller.keyAppBar,
              top: controller.positionTopAppBar.value,
              left: 0,
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
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
                    SizedBox(
                      width: 16.0,
                    ),
                    if (controller.chapter.value != null)
                      Text(
                        "Chapter ${controller.chapter.value?.chapter}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              // bottomLeft
                              offset: Offset(-1.5, -1.5),
                              blurRadius: 5,
                              color: theme.primaryColor,
                            ),
                            Shadow(
                              // bottomRight
                              offset: Offset(1.5, -1.5),
                              blurRadius: 5,
                              color: theme.primaryColor,
                            ),
                            Shadow(
                              // topRight
                              offset: Offset(1.5, 1.5),
                              blurRadius: 5,
                              color: theme.primaryColor,
                            ),
                            Shadow(
                              // topLeft
                              offset: Offset(-1.5, 1.5),
                              blurRadius: 5,
                              color: theme.primaryColor,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              key: controller.keyBottomBar,
              bottom: controller.positionBottomBottomBar.value,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (controller.stateComicDetail.value !=
                        RequestState.loading)
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
                    if (controller.stateComicDetail.value !=
                        RequestState.loading)
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
            )
          ],
        ),
      ),
    );
  }
}
