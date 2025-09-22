import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color pineGreen = Color(0xFF00796B);
  static const Color verdigris = Color(0xFF4DB6AC);
  static const Color gunMetal = Color(0xFF263238);
  static const Color russet = Color(0xFFA93800);
  static const Color grey = Color(0xFFACADAC);
  static const Color softPeach = Color(0xFFECEFF1);
  static const Color iron = Color(0xFFCFD8DC);
  static const Color green = Color(0xFF00C44A);
  static const Color red = Color(0xFFDC3837);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF111111);

  static const Color transparent = Color(0x00000000);

  static const List<Color> chartColors = [
    Color(0xFFFFFF00),
    Color(0xFF7B1FA2),
    Color(0xFFF57F17),
    Color(0xFF2AD36E),
    Color(0xFF01579B),
    Color(0xFFBF360C),
    Color(0xFF795548),
    Color(0xFF80D8FF),
    Color(0xFF607D8B),
    Color(0xFFB388FF),
    Color(0xFFFFFF8D),
    Color(0xFF004D40),
    Color(0xFFFBC02D),
    Color(0xFFFF5722),
  ];
}

Color primary() => AppColors.pineGreen;
Color accent() => AppColors.russet;

final customColors = ColorScheme.light(
  surface: Colors.white,
  surfaceVariant: Colors.grey.shade200,
  primary: Colors.deepPurple,
  primaryContainer: Colors.deepPurple.shade100,
  error: Colors.red,
  errorContainer: Colors.red.shade100,
  onErrorContainer: Colors.red.shade900,
  onSurfaceVariant: Colors.grey.shade600,
  outlineVariant: Colors.grey.shade300,
);
