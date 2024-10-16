import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikomik/presentation/pages/browser_in_app/browser_in_app_page.dart';

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
              onTap: () => Get.to(
                BrowserInAppPage(
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
              onTap: () => Get.to(
                BrowserInAppPage(
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
