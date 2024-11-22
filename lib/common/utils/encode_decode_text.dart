import 'dart:convert';

String encodeText(String text) {
  return base64Encode(utf8.encode(text));
}

String decodeText(String encodedText) {
  return utf8.decode(base64Decode(encodedText));
}
