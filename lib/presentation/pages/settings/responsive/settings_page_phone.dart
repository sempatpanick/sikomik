import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/theme.dart';
import '../../../controllers/main_controller.dart';
import '../../browser_in_app/browser_in_app_page.dart';
import '../../login/login_page.dart';
import '../../register/register_page.dart';

class SettingsPagePhone extends StatelessWidget {
  const SettingsPagePhone({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: bgColor,
      body: GetX<MainController>(
        builder: (controller) => SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (controller.user.value != null)
                      Expanded(
                        child: Text(
                          "Welcome ${(controller.user.value?.displayName ?? "").isNotEmpty ? controller.user.value?.displayName : (controller.user.value?.email ?? "").isNotEmpty ? controller.user.value?.email : ""}",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    if (controller.user.value == null)
                      ElevatedButton(
                        onPressed: () => Get.toNamed(LoginPage.routeName),
                        child: Text(
                          "Login",
                        ),
                      ),
                    if (controller.user.value == null)
                      SizedBox(
                        width: 8.0,
                      ),
                    if (controller.user.value == null)
                      ElevatedButton(
                        onPressed: () => Get.toNamed(RegisterPage.routeName),
                        child: Text(
                          "Sign up",
                        ),
                      ),
                    if (controller.user.value != null)
                      ElevatedButton(
                        onPressed: controller.logout,
                        child: Text(
                          "Logout",
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              const Divider(),
              ListTile(
                onTap: () => Get.toNamed(
                  BrowserInAppPage.routeName.replaceAll(
                    "/:path",
                    "/privacy-policy",
                  ),
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
                onTap: () => Get.toNamed(
                  BrowserInAppPage.routeName.replaceAll(
                    "/:path",
                    "/terms-and-conditions",
                  ),
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
      ),
    );
  }
}
