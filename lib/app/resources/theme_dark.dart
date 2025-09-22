import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'dimensions.dart';
import 'fade_transition_animation.dart';

ThemeData getDarkTheme(String? font) => ThemeData(
  useMaterial3: false,
  unselectedWidgetColor: AppColors.verdigris,
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.iOS: FadeTransitionBuilder(),
    TargetPlatform.android: FadeTransitionBuilder(),
  }),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.pineGreen,
    iconTheme: IconThemeData(
      color: AppColors.white,
      size: 24,
    ),
  ),
  scaffoldBackgroundColor: AppColors.softPeach,
  primaryColor: primary(),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: accent(),
    primary: primary(),
    brightness: Brightness.light,
    surface: AppColors.softPeach,
  ),
  primaryIconTheme: IconThemeData(color: accent()),
  fontFamily: font,
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.all(AppColors.gunMetal),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.all(AppColors.gunMetal),
    checkColor: WidgetStateProperty.all(AppColors.iron),
  ),
  buttonTheme: ButtonThemeData(
    height: 56,
    textTheme: ButtonTextTheme.accent,
    buttonColor: primary(),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    minWidth: 200,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(200, 56),
      backgroundColor: primary(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.gunMetal,
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: FONT_SIZE_21,
      fontWeight: FontWeight.bold,
      color: AppColors.gunMetal,
      height: 1.3,
    ),
    displayMedium: TextStyle(
      fontSize: FONT_SIZE_16,
      fontWeight: FontWeight.bold,
      color: AppColors.gunMetal,
      height: 1.3,
    ),
    displaySmall: TextStyle(
      fontSize: FONT_SIZE_14,
      fontWeight: FontWeight.bold,
      color: AppColors.gunMetal,
      height: 1.3,
    ),
    headlineMedium: TextStyle(
      fontSize: FONT_SIZE_12,
      fontWeight: FontWeight.bold,
      color: AppColors.gunMetal,
      height: 1.3,
    ),
    titleMedium: TextStyle(
      fontSize: FONT_SIZE_12,
      fontWeight: FontWeight.w600,
      color: AppColors.grey,
      height: 1.3,
    ),
    titleSmall: TextStyle(
      fontSize: FONT_SIZE_10,
      fontWeight: FontWeight.normal,
      color: AppColors.grey,
      height: 1.3,
    ),
    bodyLarge: TextStyle(
      fontSize: FONT_SIZE_14,
      fontWeight: FontWeight.w600,
      color: AppColors.gunMetal,
      height: 1.3,
    ),
    bodyMedium: TextStyle(
      fontSize: FONT_SIZE_14,
      fontWeight: FontWeight.normal,
      color: AppColors.gunMetal,
      height: 1.3,
    ),
    labelLarge: TextStyle(
      fontSize: FONT_SIZE_14,
      fontWeight: FontWeight.bold,
      color: AppColors.gunMetal,
      height: 1.3,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      fontSize: FONT_SIZE_14,
      fontWeight: FontWeight.w600,
      color: AppColors.gunMetal,
      height: 1.3,
    ),
    hintStyle: TextStyle(
      fontSize: FONT_SIZE_14,
      fontWeight: FontWeight.normal,
      color: AppColors.gunMetal,
      height: 1.3,
    ),
  ),
  cardTheme: CardThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 8,
    color: AppColors.white,
    shadowColor: AppColors.iron.withAlpha(40),
    margin: const EdgeInsets.all(0),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.white,
    size: 24,
  ),
  canvasColor: AppColors.softPeach,
);
