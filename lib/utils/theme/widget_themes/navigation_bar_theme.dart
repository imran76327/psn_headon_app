import '../../constants/colors.dart';
import 'package:flutter/material.dart';

class TNavigationBarTheme {
  TNavigationBarTheme._();

  static NavigationBarThemeData lightNavigationBarTheme =
      NavigationBarThemeData(
    backgroundColor: TColors.navigationBarBackgroundLight,
    elevation: 0,
    indicatorColor: TColors.primary,
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(color: TColors.white);
      }
      return const IconThemeData(color: TColors.darkerGrey);
    }),
  );

  static NavigationBarThemeData darkNavigationBarTheme = NavigationBarThemeData(
    backgroundColor: TColors.navigationBarBackgroundDark,
    indicatorColor: TColors.primaryDark,
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(color: TColors.white);
      }
      return const IconThemeData(color: TColors.white);
    }),
  );
}
