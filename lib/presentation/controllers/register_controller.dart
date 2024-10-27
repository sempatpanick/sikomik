import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/enums.dart';
import '../../common/failure.dart';
import '../../common/snackbar.dart';
import '../../domain/usecases/authentication_case.dart';
import '../../injection.dart';
import 'main_controller.dart';

class RegisterController extends GetxController {
  final AuthenticationCase authenticationCase = locator();

  final MainController mainController = Get.find<MainController>();

  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  Rx<RequestState> loadingState = RequestState.empty.obs;

  Future<void> register({required LoginType type}) async {
    changeLoadingState(RequestState.loading);

    Either<Failure, UserCredential>? result;

    if (type == LoginType.email) {
      if (emailInputController.text.isEmpty ||
          passwordInputController.text.isEmpty) {
        changeLoadingState(RequestState.error);
        failedSnackBar(
          "Failed",
          "Email or Password can't be empty",
        );
        return;
      }

      result = await authenticationCase.register(
        email: emailInputController.text,
        password: passwordInputController.text,
      );
    } else {
      result = await authenticationCase.login(
        type: type,
      );
    }

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
        "Register Success",
      );
      mainController.getUser();
    });
  }

  void changeLoadingState(RequestState state) {
    loadingState.value = state;
    loadingState.refresh();
  }
}
