import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/state_enum.dart';
import '../../../../common/theme.dart';
import '../../../controllers/chapter_controller.dart';

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
      body: GetX<ChapterController>(
        builder: (controller) => controller.stateChapter.value ==
                    RequestState.loading ||
                controller.chapter.value == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : InteractiveViewer(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.chapter.value?.images?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = controller.chapter.value!.images![index];

                    return Image.network(
                      item,
                      width: double.infinity,
                      loadingBuilder: (context, child, event) => event == null
                          ? child
                          : SizedBox(
                              width: double.infinity,
                              height: 300,
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
      ),
    );
  }
}
