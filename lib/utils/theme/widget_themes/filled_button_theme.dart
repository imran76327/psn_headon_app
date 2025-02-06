import '../../constants/colors.dart';
import 'package:flutter/material.dart';

class TFilledButtonTheme {
  TFilledButtonTheme._();

  static FilledButtonThemeData lightFilledButtonTheme = FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(TColors.buttonPrimary),
      padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
      shape: WidgetStateProperty.all(const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      )),
      textStyle: WidgetStateProperty.all(const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      )),
    ),
  );

  static FilledButtonThemeData darkFilledButtonTheme = FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(TColors.buttonPrimary),
      padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
      shape: WidgetStateProperty.all(const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      )),
      textStyle: WidgetStateProperty.all(const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      )),
    ),
  );
}
