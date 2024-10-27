import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import 'responsive/login_page_phone.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = "/login";

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (_) {
        // if (ResponsiveBreakpoints.of(context).isMobile) {
        if (size.width < 700) {
          return const LoginPagePhone();
        }

        return const LoginPagePhone();
      },
    );
  }
}
