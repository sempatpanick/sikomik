import 'dart:ui';

extension IntColorComponents on Color {
  int get intAlpha => a ~/ 255;
  int get intRed => r ~/ 255;
  int get intGreen => g ~/ 255;
  int get intBlue => b ~/ 255;

  String colorToHex(Color color, {bool includeAlpha = true}) {
    String alpha =
        includeAlpha ? color.intAlpha.toRadixString(16).padLeft(2, '0') : '';
    String red = color.intRed.toRadixString(16).padLeft(2, '0');
    String green = color.intGreen.toRadixString(16).padLeft(2, '0');
    String blue = color.intBlue.toRadixString(16).padLeft(2, '0');
    return '#$alpha$red$green$blue'.toUpperCase();
  }

  String getWebColor() {
    String red = intRed.toRadixString(16).padLeft(2, '0');
    String green = intGreen.toRadixString(16).padLeft(2, '0');
    String blue = intBlue.toRadixString(16).padLeft(2, '0');

    return '#$red$green$blue'.toUpperCase();
  }
}
