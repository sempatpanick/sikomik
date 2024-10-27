import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/enums.dart';
import '../../common/snackbar.dart';
import '../../domain/usecases/authentication_case.dart';
import '../../injection.dart';
import 'main_controller.dart';

class LoginController extends GetxController {
  final AuthenticationCase authenticationCase = locator();

  final MainController mainController = Get.find<MainController>();

  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  Rx<RequestState> loadingState = RequestState.empty.obs;

  Future<void> login({required LoginType type}) async {
    changeLoadingState(RequestState.loading);

    if (type == LoginType.email &&
        (emailInputController.text.isEmpty ||
            passwordInputController.text.isEmpty)) {
      changeLoadingState(RequestState.error);
      failedSnackBar(
        "Failed",
        "Email or Password can't be empty",
      );
      return;
    }

    final result = await authenticationCase.login(
      email: type != LoginType.email ? null : emailInputController.text,
      password: type != LoginType.email ? null : passwordInputController.text,
      type: type,
    );

    result.fold((l) {
      changeLoadingState(RequestState.error);
      failedSnackBar(
        "Failed",
        l.message,
      );
    }, (r) {
      changeLoadingState(RequestState.loaded);
      Get.back();
      successSnackBar(
        "Success",
        "Login Success",
      );
      mainController.getUser();
    });
  }

  void changeLoadingState(RequestState state) {
    loadingState.value = state;
    loadingState.refresh();
  }
}
