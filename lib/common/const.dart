import 'package:flutter/material.dart';

const String baseUrl = "https://comic.ddg.my.id";
const String baseUrlImage = "https://cover.komiku.id/wp-content/uploads";
const String appName = "Si Komik";

const linearGradientShimmer = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
