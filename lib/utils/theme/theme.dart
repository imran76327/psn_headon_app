import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'widget_themes/appbar_theme.dart';
import 'widget_themes/bottom_sheet_theme.dart';
import 'widget_themes/card_theme.dart';
import 'widget_themes/checkbox_theme.dart';
import 'widget_themes/chip_theme.dart';
import 'widget_themes/elevated_button_theme.dart';
import 'widget_themes/filled_button_theme.dart';
import 'widget_themes/floating_action_button_theme.dart';
import 'widget_themes/icon_button_theme.dart';
import 'widget_themes/navigation_bar_theme.dart';
import 'widget_themes/outlined_button_theme.dart';
import 'widget_themes/tab_bar_theme.dart';
import 'widget_themes/text_button_theme.dart';
import 'widget_themes/text_field_theme.dart';
import 'widget_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
        primary: TColors.primary,
        brightness: Brightness.light,
        onPrimary: TColors.black,
        secondary: TColors.secondary,
        error: TColors.error,
        onError: TColors.white,
        onSecondary: TColors.darkBlack,
        onSurface: TColors.lightlighter,
        inversePrimary: TColors.darkLight,
        surface: TColors.primaryBackground),
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: TColors.dark,
    primaryColorLight: TColors.primaryLight,
    primaryColorDark: TColors.primaryDark,
    brightness: Brightness.light,
    primaryColor: TColors.primary,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: TColors.lightGrey,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    navigationBarTheme: TNavigationBarTheme.lightNavigationBarTheme,
    floatingActionButtonTheme:
        TFloatingActionButtonTheme.lightFloatingActionButtonTheme,
    iconButtonTheme: TIconButtonTheme.lightIconButtonTheme,
    filledButtonTheme: TFilledButtonTheme.lightFilledButtonTheme,
    tabBarTheme: TTabBarTheme.lightTabBarTheme,
    textButtonTheme: TTextButtonTheme.lightTextButtonTheme,
    cardTheme: TCardTheme.lightCardTheme,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme(
        primary: TColors.primary,
        brightness: Brightness.dark,
        onPrimary: TColors.white,
        secondary: TColors.secondary,
        error: TColors.error,
        onError: TColors.white,
        onSecondary: TColors.primaryBackground,
        onSurface: TColors.darkBlack,
        inversePrimary: TColors.darkLight,
        surface: TColors.dark),
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: TColors.grey,
    brightness: Brightness.dark,
    primaryColor: TColors.primary,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    primaryColorLight: TColors.primaryLight,
    primaryColorDark: TColors.primaryDark,
    scaffoldBackgroundColor: TColors.dark,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    navigationBarTheme: TNavigationBarTheme.darkNavigationBarTheme,
    floatingActionButtonTheme:
        TFloatingActionButtonTheme.darkFloatingActionButtonTheme,
    iconButtonTheme: TIconButtonTheme.darkIconButtonTheme,
    filledButtonTheme: TFilledButtonTheme.darkFilledButtonTheme,
    tabBarTheme: TTabBarTheme.darkTabBarTheme,
    textButtonTheme: TTextButtonTheme.darkTextButtonTheme,
    cardTheme: TCardTheme.darkCardTheme,
  );
}
