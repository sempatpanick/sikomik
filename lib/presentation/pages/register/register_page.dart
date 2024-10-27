import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/register_controller.dart';
import 'responsive/register_page_phone.dart';

class RegisterPage extends StatelessWidget {
  static const String routeName = "/register";

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (_) {
        // if (ResponsiveBreakpoints.of(context).isMobile) {
        if (size.width < 700) {
          return const RegisterPagePhone();
        }

        return const RegisterPagePhone();
      },
    );
  }
}
