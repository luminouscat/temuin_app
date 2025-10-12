import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomColors {
  static Color darkPrimaryColor = const Color.fromRGBO(48, 63, 159, 1);
  static Color lightPrimaryColor = const Color.fromRGBO(197, 202, 233, 1);
  static Color primaryColor = const Color.fromRGBO(63, 81, 181, 1);
  static Color accentColor = const Color.fromRGBO(124, 77, 255, 1);
  static Color primaryText = const Color.fromRGBO(33, 33, 33, 1);
  static Color secondaryText = const Color.fromRGBO(117, 117, 117, 1);
  static Color dividerColor = const Color.fromRGBO(189, 189, 189, 1);
  static Color primaryPurple = const Color.fromRGBO(181, 63, 140, 1);
  static Color primaryYellow = const Color.fromRGBO(232, 210, 85, 1);
  static Color primaryGreen = const Color.fromRGBO(63, 181, 104, 1);
  static Color blueGradient = const Color.fromARGB(255, 37, 99, 235);
  static Color purpleGradient = const Color.fromARGB(255, 147, 51, 234);
}

final ThemeData primaryTheme = ThemeData(
  // seed
  colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.primaryColor),

  // material 3
  useMaterial3: true,

  // scaffold
  scaffoldBackgroundColor: Colors.grey[100],

  // all fonts
  fontFamily: GoogleFonts.nunito().fontFamily,

  // appBar
  appBarTheme: AppBarTheme(
    backgroundColor: CustomColors.darkPrimaryColor,
    foregroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),

  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: CustomColors.primaryText,
      fontSize: 16,
      letterSpacing: 1,
    ),
    headlineMedium: TextStyle(
      color: CustomColors.primaryText,
      fontSize: 18,
      letterSpacing: 1,
    ),
    labelMedium: TextStyle(
      color: CustomColors.dividerColor,
      fontSize: 15,
      letterSpacing: 1,
    ),
    titleMedium: TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 1),
  ),

  cardTheme: CardThemeData(
    color: Colors.white,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.only(bottom: 16),
    clipBehavior: Clip.antiAlias,
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: CustomColors.primaryPurple,
  ),
);
