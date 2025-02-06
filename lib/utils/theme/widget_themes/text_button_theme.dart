import '../../constants/colors.dart';
import 'package:flutter/material.dart';

class TTextButtonTheme {
  TTextButtonTheme._();

  static TextButtonThemeData lightTextButtonTheme = TextButtonThemeData(
      style: ButtonStyle(
    foregroundColor: WidgetStateProperty.all(TColors.primary),
  ));

  static TextButtonThemeData darkTextButtonTheme = TextButtonThemeData(
      style: ButtonStyle(
    foregroundColor: WidgetStateProperty.all(TColors.primary),
  ));
}
