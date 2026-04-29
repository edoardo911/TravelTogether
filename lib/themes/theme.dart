import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF0066FF),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF00C2FF),
      onSecondary: Color(0xFF000000),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF000000),
      error: Color(0xFFB00020),
      onError: Color(0xFFFFFFFF),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF8139B1),
      onPrimary: Color(0xFF000000),
      secondary: Color(0xFFAFBBF2),
      onSecondary: Color(0xFF000000),
      surface: Color(0xFF121212),
      onSurface: Color(0xFFFFFFFF),
      error: Color(0xFFCF6679),
      onError: Color(0xFF000000),
    ),
  );
}