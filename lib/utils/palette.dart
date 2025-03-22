import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Palette {
  /* Color */
  static const Color primary = Color(0xFF198754);
  static const Color secondary = Color(0xFFAE7560);
  static const Color container = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8F9FA);
  static const Color surfaceVariant = Color(0xFFF6F6F6);
  static const Color onSurface = Color(0xFF212529);
  static const Color onSurfaceVariant = Color(0xFFA2A4A6);
  static const Color error = Color(0xFFDC3545);
  static const Color success = Color(0xFF198754);
  /* Typography */
  static TextStyle largeTitle = TextStyle(
    fontSize: 34.sp,
    fontWeight: FontWeight.w700,
    height: 1,
  );
  static TextStyle title = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w600,
    height: 1,
  );
  static TextStyle headline = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
    height: 1,
  );
  static TextStyle body = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
  static TextStyle callout = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1,
  );
  static TextStyle caption = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1,
  );
}
