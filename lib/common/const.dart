import 'package:flutter/material.dart';

const String baseUrl = "https://comic-v2.ddg.my.id";
const String baseUrlImage =
    "https://i2.wp.com/bacakomik.net/wp-content/uploads";
const String baseUrlImageCdn = "https://5ln1h5525y2q.kentut.xyz/data";
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
