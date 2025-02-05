import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    sliderTheme: const SliderThemeData(
      overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
    ),
  );
}
