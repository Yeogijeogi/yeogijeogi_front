import 'package:flutter/material.dart';

class Palette {
  /* Color */
  static const Color primary = Color(0xFFA785C7);
  static const Color secondary = Color(0xFF6C88C4);
  static const Color container = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8F9FA);
  static const Color onSurface = Color(0xFF212529);
  static const Color onSurfaceVariant = Color(0xFFA2A4A6);
  static const Color error = Color(0xFFDC3545);
  static const Color success = Color(0xFF198754);

  /* Typography */
  static const TextStyle largeTitle = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    height: 1,
  );
  static const TextStyle largeTitleSemibold = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w600,
    height: 1,
  );
  static const TextStyle title = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1,
  );
  static const TextStyle headline = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1,
  );
  static const TextStyle body = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
  static const TextStyle callout = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1,
  );
}
