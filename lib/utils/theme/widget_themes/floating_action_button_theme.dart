import '../../constants/colors.dart';
import 'package:flutter/material.dart';

class TFloatingActionButtonTheme {
  TFloatingActionButtonTheme._();

  static FloatingActionButtonThemeData lightFloatingActionButtonTheme =
      const FloatingActionButtonThemeData(
    backgroundColor: TColors.buttonPrimary,
    foregroundColor: TColors.white,
    elevation: 4,
    focusElevation: 6,
    hoverElevation: 6,
    highlightElevation: 8,
    disabledElevation: 0,
    shape: StadiumBorder(),
    extendedTextStyle: TextStyle(
      color: TColors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  );

  static FloatingActionButtonThemeData darkFloatingActionButtonTheme =
      const FloatingActionButtonThemeData(
    backgroundColor: TColors.buttonPrimary,
    foregroundColor: TColors.white,
    elevation: 4,
    focusElevation: 6,
    hoverElevation: 6,
    highlightElevation: 8,
    disabledElevation: 0,
    shape: StadiumBorder(),
    extendedTextStyle: TextStyle(
      color: TColors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  );
}
