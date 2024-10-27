import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toastification/toastification.dart';

Future<bool?> successSnackBar(
  String title,
  String message, {
  int durationSecond = 3,
  double width = 400,
  bool isShowIcon = false,
  Color backgroundColor = Colors.green,
}) async {
  if (kIsWeb ||
      kIsWasm ||
      Platform.isWindows ||
      Platform.isMacOS ||
      Platform.isLinux) {
    toastification.show(
      title: title.isEmpty ? null : Text(title),
      description: message.isEmpty ? null : Text(message),
      autoCloseDuration: Duration(seconds: durationSecond),
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      alignment: Alignment.topRight,
      primaryColor: Colors.white,
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
      borderSide: BorderSide.none,
      padding: EdgeInsets.all(8),
      icon: !isShowIcon ? null : const Icon(Icons.check_circle_outline),
    );
    await Future.delayed(Duration(seconds: durationSecond));
    return true;
  }
  return Fluttertoast.showToast(
    msg: message,
    backgroundColor: backgroundColor,
    webBgColor:
        "#${backgroundColor.value.toRadixString(16).substring(2, backgroundColor.value.toRadixString(16).length)}",
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: durationSecond,
  );
}

Future<bool?> failedSnackBar(
  String title,
  String message, {
  int durationSecond = 3,
  double width = 400,
  bool isShowIcon = false,
  Color backgroundColor = Colors.redAccent,
}) async {
  if (kIsWeb ||
      kIsWasm ||
      Platform.isWindows ||
      Platform.isMacOS ||
      Platform.isLinux) {
    toastification.show(
      title: Text(title),
      description: Text(message),
      autoCloseDuration: Duration(seconds: durationSecond),
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      alignment: Alignment.topRight,
      primaryColor: Colors.white,
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
      borderSide: BorderSide.none,
      padding: EdgeInsets.all(8),
      icon: !isShowIcon ? null : const Icon(Icons.cancel_outlined),
    );
    await Future.delayed(Duration(seconds: durationSecond));
    return true;
  }
  return Fluttertoast.showToast(
    msg: message,
    backgroundColor: backgroundColor,
    webBgColor:
        "#${backgroundColor.value.toRadixString(16).substring(2, backgroundColor.value.toRadixString(16).length)}",
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: durationSecond,
  );
}
