import 'package:flutter/material.dart';

class TColors {
  // App theme colors
  static const Color primary = Color.fromARGB(255, 255, 0, 0);
  static const Color primaryDark = Color.fromRGBO(156, 0, 0, 1);
  static const Color primaryLight = Color.fromRGBO(255, 150, 150, 1);
  static const Color secondary = Color.fromARGB(255, 32, 191, 191);
  static const Color accent = Color(0xFFb0c7ff);

  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

  // Background colors
  static const Color light = Color.fromARGB(255, 224, 224, 224);
  static const Color lightdark = Color.fromARGB(255, 222, 216, 216);
  static const Color lightlighter = Color.fromARGB(255, 255, 255, 255);
  static const Color dark = Color.fromARGB(255, 0, 0, 0);
  static const Color primaryBackground = Color(0xFFF3F5FF);
  static const Color darkBlack = Color.fromARGB(255, 20, 19, 19);
  static const Color darkLight = Color.fromARGB(255, 83, 78, 78);

  // Background Container colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = TColors.white.withOpacity(0.1);

  // Button colors
  static const Color buttonPrimary = primary;
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);
  static const Color blue = Color.fromARGB(255, 14, 94, 174);
  static const Color blurDark = Color.fromARGB(255, 7, 58, 110);
  static const Color blurLight = Color.fromARGB(255, 59, 144, 230);
  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);

  // Text Field Colors
  static const Color textFieldBackgroundLight = Color(0xFFF6F6F6);
  static const Color textFieldBackgroundDark = Color(0xFF272727);

  // Navigation Bar Colors
  static const Color navigationBarBackgroundLight =
      Color.fromARGB(255, 255, 243, 231);
  static const Color navigationBarBackgroundDark = Color(0xFF272727);

  // Misc
  static const Color transparent = Colors.transparent;
}
