// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:sikomik/presentation/pages/browser_in_app/browser_in_app_page.dart'
    as _i1;
import 'package:sikomik/presentation/pages/chapter/chapter_page.dart' as _i2;
import 'package:sikomik/presentation/pages/comic_detail/comic_detail_page.dart'
    as _i3;
import 'package:sikomik/presentation/pages/home/home_page.dart' as _i4;
import 'package:sikomik/presentation/pages/main/main_page.dart' as _i5;
import 'package:sikomik/presentation/pages/settings/settings_page.dart' as _i6;

/// generated route for
/// [_i1.BrowserInAppPage]
class BrowserInAppRoute extends _i7.PageRouteInfo<BrowserInAppRouteArgs> {
  BrowserInAppRoute({
    _i8.Key? key,
    required String url,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          BrowserInAppRoute.name,
          args: BrowserInAppRouteArgs(
            key: key,
            url: url,
          ),
          initialChildren: children,
        );

  static const String name = 'BrowserInAppRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BrowserInAppRouteArgs>();
      return _i1.BrowserInAppPage(
        key: args.key,
        url: args.url,
      );
    },
  );
}

class BrowserInAppRouteArgs {
  const BrowserInAppRouteArgs({
    this.key,
    required this.url,
  });

  final _i8.Key? key;

  final String url;

  @override
  String toString() {
    return 'BrowserInAppRouteArgs{key: $key, url: $url}';
  }
}

/// generated route for
/// [_i2.ChapterPage]
class ChapterRoute extends _i7.PageRouteInfo<ChapterRouteArgs> {
  ChapterRoute({
    _i8.Key? key,
    required String path,
    List<_i7.PageRouteInfo>? children,
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

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ChapterRouteArgs>(
          orElse: () => ChapterRouteArgs(path: pathParams.getString('path')));
      return _i2.ChapterPage(
        key: args.key,
        path: args.path,
      );
    },
  );
}

class ChapterRouteArgs {
  const ChapterRouteArgs({
    this.key,
    required this.path,
  });

  final _i8.Key? key;

  final String path;

  @override
  String toString() {
    return 'ChapterRouteArgs{key: $key, path: $path}';
  }
}

/// generated route for
/// [_i3.ComicDetailPage]
class ComicDetailRoute extends _i7.PageRouteInfo<ComicDetailRouteArgs> {
  ComicDetailRoute({
    _i8.Key? key,
    required String path,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          ComicDetailRoute.name,
          args: ComicDetailRouteArgs(
            key: key,
            path: path,
          ),
          rawPathParams: {'path': path},
          initialChildren: children,
        );

  static const String name = 'ComicDetailRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ComicDetailRouteArgs>(
          orElse: () =>
              ComicDetailRouteArgs(path: pathParams.getString('path')));
      return _i3.ComicDetailPage(
        key: args.key,
        path: args.path,
      );
    },
  );
}

class ComicDetailRouteArgs {
  const ComicDetailRouteArgs({
    this.key,
    required this.path,
  });

  final _i8.Key? key;

  final String path;

  @override
  String toString() {
    return 'ComicDetailRouteArgs{key: $key, path: $path}';
  }
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomePage();
    },
  );
}

/// generated route for
/// [_i5.MainPage]
class MainRoute extends _i7.PageRouteInfo<void> {
  const MainRoute({List<_i7.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.MainPage();
    },
  );
}

/// generated route for
/// [_i6.SettingsPage]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SettingsPage();
    },
  );
}
