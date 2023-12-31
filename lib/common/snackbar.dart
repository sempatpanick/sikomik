import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> successSnackBar(
  String title,
  String message, {
  int durationSecond = 3,
  double width = 400,
  bool isShowIcon = false,
  Color backgroundColor = Colors.green,
}) {
  return Fluttertoast.showToast(
    msg: message,
    backgroundColor: backgroundColor,
    webBgColor:
        "#${backgroundColor.value.toRadixString(16).substring(2, backgroundColor.value.toRadixString(16).length)}",
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: durationSecond,
  );
  // return Get.snackbar(
  //   title,
  //   message,
  //   margin: const EdgeInsets.only(top: 16, left: 16.0, right: 16.0),
  //   padding: title.isEmpty
  //       ? const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 15.0)
  //       : null,
  //   titleText: title.isEmpty ? const SizedBox() : null,
  //   messageText: isShowIcon || title.isNotEmpty
  //       ? Text(
  //           message,
  //           style: const TextStyle(
  //             color: Colors.white,
  //           ),
  //         )
  //       : Center(
  //           child: Text(
  //             message,
  //             style: const TextStyle(
  //               color: Colors.white,
  //             ),
  //           ),
  //         ),
  //   icon: isShowIcon ? const Icon(Icons.check_circle_outline) : null,
  //   duration: Duration(seconds: durationSecond),
  //   colorText: Colors.white,
  //   backgroundColor: backgroundColor,
  //   maxWidth: Get.size.width <= 700 ? width : 400,
  //   dismissDirection: DismissDirection.horizontal,
  //   borderRadius: 8.0,
  // );
}

Future<bool?> failedSnackBar(
  String title,
  String message, {
  int durationSecond = 3,
  double width = 400,
  bool isShowIcon = false,
  Color backgroundColor = Colors.red,
}) {
  return Fluttertoast.showToast(
    msg: message,
    backgroundColor: backgroundColor,
    webBgColor:
        "#${backgroundColor.value.toRadixString(16).substring(2, backgroundColor.value.toRadixString(16).length)}",
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: durationSecond,
  );
  // return Get.snackbar(
  //   title,
  //   message,
  //   margin: const EdgeInsets.only(top: 16, left: 16.0, right: 16.0),
  //   padding: title.isEmpty
  //       ? const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 15.0)
  //       : null,
  //   titleText: title.isEmpty ? const SizedBox() : null,
  //   messageText: isShowIcon || title.isNotEmpty
  //       ? Text(
  //           message,
  //           style: const TextStyle(
  //             color: Colors.white,
  //           ),
  //         )
  //       : Center(
  //           child: Text(
  //             message,
  //             style: const TextStyle(
  //               color: Colors.white,
  //             ),
  //           ),
  //         ),
  //   icon: isShowIcon
  //       ? const Icon(
  //           Icons.close,
  //           color: Colors.white,
  //         )
  //       : null,
  //   duration: Duration(seconds: durationSecond),
  //   colorText: Colors.white,
  //   backgroundColor: backgroundColor,
  //   maxWidth: Get.size.width <= 700 ? width : 400,
  //   dismissDirection: DismissDirection.horizontal,
  //   borderRadius: 8.0,
  // );
}
