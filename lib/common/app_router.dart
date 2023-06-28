import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../presentation/pages/browser_in_app/browser_in_app_page.dart';
import '../presentation/pages/chapter/chapter_page.dart';
import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/main/main_page.dart';
import '../presentation/pages/manga_detail/manga_detail_page.dart';
import '../presentation/pages/settings/settings_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainRoute.page,
          path: MainPage.routeName,
          initial: true,
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: HomePage.routeName,
        ),
        AutoRoute(
          page: MangaDetailRoute.page,
          path: MangaDetailPage.routeName,
        ),
        AutoRoute(
          page: ChapterRoute.page,
          path: ChapterPage.routeName,
        ),
        AutoRoute(
          page: SettingsRoute.page,
          path: SettingsPage.routeName,
        ),
        AutoRoute(
          page: BrowserInAppRoute.page,
          path: BrowserInAppPage.routeName,
        ),
      ];
}
