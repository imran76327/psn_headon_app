import '../../constants/colors.dart';
import 'package:flutter/material.dart';

class TTabBarTheme {
  TTabBarTheme._();

  static const TabBarTheme lightTabBarTheme = TabBarTheme(
    labelColor: TColors.darkerGrey,
    unselectedLabelColor: TColors.darkGrey,
    labelStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    indicatorColor: TColors.primary,
  );

  static const TabBarTheme darkTabBarTheme = TabBarTheme(
    labelColor: TColors.darkerGrey,
    unselectedLabelColor: TColors.darkGrey,
    labelStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    indicatorColor: TColors.primary,
  );
}
