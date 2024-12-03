import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../common/enums.dart';
import '../../../../common/theme.dart';
import '../../../controllers/login_controller.dart';
import '../../../controllers/main_controller.dart';
import '../../main/main_page.dart';
import '../../register/register_page.dart';

class LoginPagePhone extends StatelessWidget {
  const LoginPagePhone({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () async {
            final isCanPop = await Navigator.of(context).maybePop();
            if (!isCanPop) {
              final mainController = Get.find<MainController>();
              mainController.changeSelectedIndexNav(1);
              Get.offAllNamed(
                MainPage.routeName,
                arguments: 1,
              );
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
      body: GetX<LoginController>(
        builder: (controller) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 40,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "LOGIN",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: controller.emailInputController,
                  enabled:
                      controller.loadingState.value != RequestState.loading,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Email",
                    hintText: "john@example.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                TextFormField(
                  controller: controller.passwordInputController,
                  enabled:
                      controller.loadingState.value != RequestState.loading,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                  ),
                  onFieldSubmitted:
                      controller.loadingState.value == RequestState.loading
                          ? null
                          : (_) => controller.login(
                                context: context,
                                type: LoginType.email,
                              ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed:
                        controller.loadingState.value == RequestState.loading
                            ? null
                            : () => controller.login(
                                  context: context,
                                  type: LoginType.email,
                                ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 45),
                    ),
                    icon: Icon(Icons.send),
                    label: Text(
                      "Login",
                    ),
                  ),
                ),
                if (!kIsWasm && !kIsWeb && Platform.isAndroid && Platform.isIOS)
                  Row(
                    children: [
                      Expanded(
                        child: Divider(),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "OR",
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                if (!kIsWasm && !kIsWeb && Platform.isAndroid && Platform.isIOS)
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      onPressed:
                          controller.loadingState.value == RequestState.loading
                              ? null
                              : () => controller.login(
                                    context: context,
                                    type: LoginType.google,
                                  ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 45),
                      ),
                      icon: Icon(FontAwesomeIcons.google),
                      label: Text(
                        "Continue with Google",
                      ),
                    ),
                  ),
                if (!kIsWasm && !kIsWeb && Platform.isAndroid && Platform.isIOS)
                  SizedBox(
                    height: 8.0,
                  ),
                if (!kIsWasm && !kIsWeb && Platform.isAndroid && Platform.isIOS)
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      onPressed:
                          controller.loadingState.value == RequestState.loading
                              ? null
                              : () => controller.login(
                                    context: context,
                                    type: LoginType.facebook,
                                  ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 45),
                      ),
                      icon: Icon(FontAwesomeIcons.facebook),
                      label: Text(
                        "Continue with Facebook",
                      ),
                    ),
                  ),
                SizedBox(
                  height: 16.0,
                ),
                RichText(
                  text: TextSpan(
                    text: "Do you want to create an account? ",
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                    children: [
                      WidgetSpan(
                        child: TextButton(
                          onPressed: () => Get.offNamed(RegisterPage.routeName),
                          style: TextButton.styleFrom(
                            minimumSize: Size(0, 0),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            "Signup here",
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (controller.loadingState.value == RequestState.loading)
                  SizedBox(
                    height: 16,
                  ),
                if (controller.loadingState.value == RequestState.loading)
                  LinearProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
