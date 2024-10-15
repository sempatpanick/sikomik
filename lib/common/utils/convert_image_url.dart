import 'package:flutter/foundation.dart';

import '../const.dart';

String? imageUrlFromJson(dynamic data) {
  if (data is String) {
    if (data.startsWith(baseUrlImageCdn)) {
      return kIsWeb || kIsWasm
          ? data.replaceFirst(baseUrlImageCdn, "$baseUrl/images/cdn")
          : data;
    }
    return kIsWeb || kIsWasm
        ? "$baseUrl$data"
        : data.replaceFirst("/images", baseUrlImage);
  }

  return data;
}

String? imageUrlToJson(String? data) {
  if (data?.startsWith(baseUrlImageCdn) ?? false) {
    return kIsWeb || kIsWasm
        ? data?.replaceFirst("$baseUrl/images/cdn", baseUrlImageCdn)
        : data;
  }
  return kIsWeb || kIsWasm
      ? "$baseUrl$data"
      : data?.replaceFirst(baseUrlImage, "/images");
}

List<String>? imageUrlListFromJson(dynamic data) {
  if (data is List<String> || data is List<dynamic>) {
    return (data as List<dynamic>).map((item) {
      if (item.toString().startsWith(baseUrlImageCdn)) {
        return kIsWeb || kIsWasm
            ? item
                .toString()
                .replaceFirst(baseUrlImageCdn, "$baseUrl/images/cdn")
            : item.toString();
      }
      return kIsWeb || kIsWasm
          ? "$baseUrl$item"
          : item.toString().replaceFirst("/images", baseUrlImage);
    }).toList();
  }

  return (data as List<dynamic>).map((item) => item.toString()).toList();
}

List<String>? imageUrlListToJson(List<String>? data) {
  return data?.map((item) {
    if (item.startsWith(baseUrlImageCdn)) {
      return kIsWeb || kIsWasm
          ? item.replaceFirst("$baseUrl/images/cdn", baseUrlImageCdn)
          : item;
    }
    return kIsWeb || kIsWasm
        ? "$baseUrl$item"
        : item.replaceFirst(baseUrlImage, "/images");
  }).toList();
}
