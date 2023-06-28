// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BrowserInAppRoute.name: (routeData) {
      final args = routeData.argsAs<BrowserInAppRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BrowserInAppPage(
          key: args.key,
          url: args.url,
        ),
      );
    },
    ChapterRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChapterRouteArgs>(
          orElse: () => ChapterRouteArgs(path: pathParams.getString('path')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChapterPage(
          key: args.key,
          path: args.path,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    MangaDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MangaDetailRouteArgs>(
          orElse: () =>
              MangaDetailRouteArgs(path: pathParams.getString('path')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MangaDetailPage(
          key: args.key,
          path: args.path,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
  };
}

/// generated route for
/// [BrowserInAppPage]
class BrowserInAppRoute extends PageRouteInfo<BrowserInAppRouteArgs> {
  BrowserInAppRoute({
    Key? key,
    required String url,
    List<PageRouteInfo>? children,
  }) : super(
          BrowserInAppRoute.name,
          args: BrowserInAppRouteArgs(
            key: key,
            url: url,
          ),
          initialChildren: children,
        );

  static const String name = 'BrowserInAppRoute';

  static const PageInfo<BrowserInAppRouteArgs> page =
      PageInfo<BrowserInAppRouteArgs>(name);
}

class BrowserInAppRouteArgs {
  const BrowserInAppRouteArgs({
    this.key,
    required this.url,
  });

  final Key? key;

  final String url;

  @override
  String toString() {
    return 'BrowserInAppRouteArgs{key: $key, url: $url}';
  }
}

/// generated route for
/// [ChapterPage]
class ChapterRoute extends PageRouteInfo<ChapterRouteArgs> {
  ChapterRoute({
    Key? key,
    required String path,
    List<PageRouteInfo>? children,
  }) : super(
          ChapterRoute.name,
          args: ChapterRouteArgs(
            key: key,
            path: path,
          ),
          rawPathParams: {'path': path},
          initialChildren: children,
        );

  static const String name = 'ChapterRoute';

  static const PageInfo<ChapterRouteArgs> page =
      PageInfo<ChapterRouteArgs>(name);
}

class ChapterRouteArgs {
  const ChapterRouteArgs({
    this.key,
    required this.path,
  });

  final Key? key;

  final String path;

  @override
  String toString() {
    return 'ChapterRouteArgs{key: $key, path: $path}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MangaDetailPage]
class MangaDetailRoute extends PageRouteInfo<MangaDetailRouteArgs> {
  MangaDetailRoute({
    Key? key,
    required String path,
    List<PageRouteInfo>? children,
  }) : super(
          MangaDetailRoute.name,
          args: MangaDetailRouteArgs(
            key: key,
            path: path,
          ),
          rawPathParams: {'path': path},
          initialChildren: children,
        );

  static const String name = 'MangaDetailRoute';

  static const PageInfo<MangaDetailRouteArgs> page =
      PageInfo<MangaDetailRouteArgs>(name);
}

class MangaDetailRouteArgs {
  const MangaDetailRouteArgs({
    this.key,
    required this.path,
  });

  final Key? key;

  final String path;

  @override
  String toString() {
    return 'MangaDetailRouteArgs{key: $key, path: $path}';
  }
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
