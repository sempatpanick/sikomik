import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/enums.dart';
import '../../common/snackbar.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/authentication_case.dart';
import '../../domain/usecases/user_detail_case.dart';
import '../../injection.dart';
import '../pages/main/main_page.dart';
import 'main_controller.dart';

class LoginController extends GetxController {
  final AuthenticationCase authenticationCase = locator();
  final UserDetailCase userDetailCase = locator();

  final MainController mainController = Get.find<MainController>();

  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  Rx<RequestState> loadingState = RequestState.empty.obs;

  Future<void> login({
    required BuildContext context,
    required LoginType type,
  }) async {
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
    }, (r) async {
      if (r.user?.uid != null) {
        final getUser = await userDetailCase.getUserDetail(userId: r.user!.uid);
        final user = getUser.foldRight(UserEntity(), (r, prev) {
          return r;
        });
        await userDetailCase.setUser(
          user: UserEntity(
            id: r.user?.uid,
            avatarUrl: r.user?.photoURL,
            name: r.user?.displayName,
            email: r.user?.email,
            phoneNumber: r.user?.phoneNumber,
            createdAt: user.createdAt == null ? DateTime.now().toUtc() : null,
            lastUpdated: DateTime.now().toUtc(),
          ),
        );
      }
      changeLoadingState(RequestState.loaded);
      if (context.mounted) {
        final isCanPop = await Navigator.of(context).maybePop();
        if (!isCanPop) {
          final mainController = Get.find<MainController>();
          mainController.changeSelectedIndexNav(1);
          Get.offAllNamed(
            MainPage.routeName,
            arguments: 1,
          );
        }
        successSnackBar(
          "Success",
          "Login Success",
        );
        mainController.getUser();
      }
    });
  }

  void changeLoadingState(RequestState state) {
    loadingState.value = state;
    loadingState.refresh();
  }
}
