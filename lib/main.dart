import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:window_size/window_size.dart';

import 'common/scroll_behavior_helper.dart';
import 'common/utils/url_strategy/url_strategy.dart';
import 'firebase_options.dart';
import 'injection.dart';
import 'presentation/controllers/main_controller.dart';
import 'presentation/pages/browser_in_app/browser_in_app_page.dart';
import 'presentation/pages/chapter/chapter_page.dart';
import 'presentation/pages/comic_detail/comic_detail_page.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/login/login_page.dart';
import 'presentation/pages/main/main_page.dart';
import 'presentation/pages/register/register_page.dart';
import 'presentation/pages/settings/settings_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if ((!kIsWeb && !kIsWasm) &&
      (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    setWindowTitle('Si Komik | Baca Komik Bahasa Indonesia');
    setWindowMinSize(const Size(450, 600));
    setWindowMaxSize(Size.infinite);
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        title: 'Si Komik | Baca Komik Bahasa Indonesia',
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
                didChangeDependencies: (state) =>
                    WidgetsBinding.instance.addPostFrameCallback(
                  (_) => state.controller?.initialize(),
                ),
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
            name: LoginPage.routeName,
            page: () => LoginPage(),
          ),
          GetPage(
            name: RegisterPage.routeName,
            page: () => RegisterPage(),
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
