import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const _bgColor = Color(0xFF151217);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    dialogBackgroundColor: _bgColor,
    scaffoldBackgroundColor: _bgColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: Brightness.dark,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}
