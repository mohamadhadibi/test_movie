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
  static const Color red = Color(0xFFBF360C);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF111111);

  static const Color transparent = Color(0x00000000);
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
