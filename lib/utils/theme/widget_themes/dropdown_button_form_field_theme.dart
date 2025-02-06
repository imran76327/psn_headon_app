import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class TDropdownButtonFormFieldTheme {
  const TDropdownButtonFormFieldTheme._();

  static DropdownMenuThemeData lightTheme = DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: TColors.darkGrey,
      suffixIconColor: TColors.darkGrey,
      labelStyle: const TextStyle()
          .copyWith(fontSize: TSizes.fontSizeMd, color: TColors.darkerGrey),
      hintStyle: const TextStyle()
          .copyWith(fontSize: TSizes.fontSizeSm, color: TColors.darkGrey),
      errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle:
          const TextStyle().copyWith(color: TColors.black.withOpacity(0.8)),
      filled: true,
      fillColor: TColors.textFieldBackgroundLight,
      border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: TColors.darkGrey),
      ),
      enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: TColors.darkGrey),
      ),
      focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: TColors.primary),
      ),
      errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: TColors.warning),
      ),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 2, color: TColors.warning),
      ),
    ),
  );

  static DropdownMenuThemeData darkTheme = DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 2,
      prefixIconColor: TColors.darkGrey,
      suffixIconColor: TColors.darkGrey,
      // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
      labelStyle: const TextStyle()
          .copyWith(fontSize: TSizes.fontSizeMd, color: TColors.white),
      hintStyle: const TextStyle()
          .copyWith(fontSize: TSizes.fontSizeSm, color: TColors.darkGrey),
      floatingLabelStyle:
          const TextStyle().copyWith(color: TColors.white.withOpacity(0.8)),
      filled: true,
      fillColor: TColors.textFieldBackgroundDark,
      border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: TColors.white),
      ),
      enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: TColors.white),
      ),
      focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: TColors.primary),
      ),
      errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: TColors.warning),
      ),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 2, color: TColors.warning),
      ),
    ),
  );
}
