import '../../constants/colors.dart';
import 'package:flutter/material.dart';

class TIconButtonTheme {
  TIconButtonTheme._();

  static IconButtonThemeData lightIconButtonTheme = IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          WidgetStateProperty.all(const Color.fromARGB(255, 245, 240, 221)),
      padding: WidgetStateProperty.all(const EdgeInsets.all(12)),
      shape: WidgetStateProperty.all(const CircleBorder()),
      iconColor: WidgetStateProperty.all(TColors.buttonPrimary),
    ),
  );

  static IconButtonThemeData darkIconButtonTheme = IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          WidgetStateProperty.all(const Color.fromARGB(255, 245, 240, 221)),
      padding: WidgetStateProperty.all(const EdgeInsets.all(12)),
      shape: WidgetStateProperty.all(const CircleBorder()),
      iconColor: WidgetStateProperty.all(TColors.buttonPrimary),
    ),
  );
}
