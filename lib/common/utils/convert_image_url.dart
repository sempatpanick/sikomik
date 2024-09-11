import '../const.dart';

String? imageUrlFromJson(dynamic data) {
  if (data is String) {
    return data.replaceFirst("/images", baseUrlImage);
  }

  return data;
}

String? imageUrlToJson(String? data) {
  return data?.replaceFirst(baseUrlImage, "/images");
}
