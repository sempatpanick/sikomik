import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_router.gr.dart';
import '../../../../common/theme.dart';

class SettingsPagePhone extends StatelessWidget {
  const SettingsPagePhone({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () => context.router.push(
                BrowserInAppRoute(
                    url: "https://komik.ddg.my.id/privacy-police.html"),
              ),
              title: Text(
                "Privacy & Police",
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            ListTile(
              onTap: () => context.router.push(
                BrowserInAppRoute(
                    url: "https://komik.ddg.my.id/terms-and-conditions.html"),
              ),
              title: Text(
                "Terms & Conditions",
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
