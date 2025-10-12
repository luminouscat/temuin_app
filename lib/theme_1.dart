import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color.fromRGBO(63, 81, 181, 1);
  static Color primaryAccent = const Color.fromRGBO(32, 59, 223, 1);
  static Color secondaryColor = const Color.fromRGBO(45, 45, 45, 1);
  static Color secondaryAccent = const Color.fromRGBO(35, 35, 35, 1);
  static Color titleColor = const Color.fromRGBO(200, 200, 200, 1);
  static Color textColor = const Color.fromRGBO(150, 150, 150, 1);
  static Color successColor = const Color.fromARGB(219, 23, 216, 132);
  static Color highlightColor = const Color.fromRGBO(212, 172, 13, 1);
}

final ThemeData primaryTheme = ThemeData(
  // these are all classes btw

  //seed
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),

  //scaffold color
  scaffoldBackgroundColor: AppColors.secondaryAccent,

  //appbar theme
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.secondaryColor,
    foregroundColor: AppColors.titleColor,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),

  //text theme
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: AppColors.textColor,
      fontSize: 16,
      letterSpacing: 1,
    ),
    headlineMedium: TextStyle(
      color: AppColors.titleColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
    titleMedium: TextStyle(
      color: AppColors.titleColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
    ),
  ),

  //card theme
  cardTheme: CardThemeData(
    color: AppColors.secondaryColor.withValues(alpha: 0.5),
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.only(bottom: 16),
  ),

  // input decoration theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.secondaryColor.withValues(alpha: 0.5),
    border: InputBorder.none,
    labelStyle: TextStyle(color: AppColors.textColor),
    prefixIconColor: AppColors.textColor,
  ),

  // dialog theme
  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.secondaryAccent,
    titleTextStyle: TextStyle(
      color: AppColors.titleColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    contentTextStyle: TextStyle(color: AppColors.textColor, fontSize: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);
