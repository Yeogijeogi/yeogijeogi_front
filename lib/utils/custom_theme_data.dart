import 'package:flutter/material.dart';
import 'package:yeogijeogi/utils/palette.dart';

class CustomThemeData {
  static final ThemeData light = ThemeData(
    fontFamily: 'Pretendard',

    // Scaffold 테마
    scaffoldBackgroundColor: Palette.surface,

    // 앱바 테마
    appBarTheme: AppBarTheme(
      titleTextStyle: Palette.headline.copyWith(color: Palette.onSurface),
      foregroundColor: Palette.onSurface,
    ),

    // 네비게이션바 테마
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Palette.container,
      selectedItemColor: Palette.onSurface,
      unselectedItemColor: Palette.onSurfaceVariant,
      selectedLabelStyle: Palette.caption,
      unselectedLabelStyle: Palette.caption,
      type: BottomNavigationBarType.fixed,
    ),

    // 앱 전체적인 테마
    colorScheme: const ColorScheme.light(
      primary: Palette.primary,
      onPrimary: Palette.surface,
      secondary: Palette.secondary,
      onSecondary: Palette.surface,
      surface: Palette.surface,
      onSurface: Palette.onSurface,
      onSurfaceVariant: Palette.onSurfaceVariant,
      error: Palette.error,
      onError: Palette.surface,
    ),
  );
}
