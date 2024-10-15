import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikomik/presentation/controllers/main_controller.dart';
import 'package:toastification/toastification.dart';
import 'package:url_strategy/url_strategy.dart';

import 'common/scroll_behavior_helper.dart';
import 'injection.dart';
import 'presentation/pages/browser_in_app/browser_in_app_page.dart';
import 'presentation/pages/chapter/chapter_page.dart';
import 'presentation/pages/comic_detail/comic_detail_page.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/main/main_page.dart';
import 'presentation/pages/settings/settings_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        title: 'Si Komik',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        scrollBehavior: ScrollBehaviorHelper(),
        // routerConfig: appRouter.config(),
        builder: (context, child) => Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (_) => GetBuilder<MainController>(
                init: MainController(),
                builder: (_) => child ?? SizedBox(),
              ),
            ),
          ],
        ),
        initialRoute: MainPage.routeName,
        getPages: [
          GetPage(
            name: MainPage.routeName,
            page: () => MainPage(),
          ),
          GetPage(
            name: HomePage.routeName,
            page: () => HomePage(),
          ),
          GetPage(
            name: ComicDetailPage.routeName,
            page: () => ComicDetailPage(),
          ),
          GetPage(
            name: ChapterPage.routeName,
            page: () => ChapterPage(),
          ),
          GetPage(
            name: SettingsPage.routeName,
            page: () => SettingsPage(),
          ),
          GetPage(
            name: BrowserInAppPage.routeName,
            page: () => BrowserInAppPage(
              url: Get.parameters['url']!,
            ),
          ),
        ],
      ),
    );
  }
}
