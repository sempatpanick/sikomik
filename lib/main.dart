import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'common/app_router.dart';
import 'common/scroll_behavior_helper.dart';
import 'injection.dart';

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
    final _appRouter = AppRouter();

    return MaterialApp.router(
      title: 'Si Komik',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      scrollBehavior: ScrollBehaviorHelper(),
      routerConfig: _appRouter.config(),
    );
  }
}
