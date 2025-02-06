import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TCardTheme {
  TCardTheme._();

  static CardTheme lightCardTheme = CardTheme(
    color: Colors.white,
    shadowColor: const Color.fromARGB(20, 45, 46, 54),
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  static CardTheme darkCardTheme = CardTheme(
    color: TColors.darkBlack,
    shadowColor: const Color.fromARGB(20, 45, 46, 54),
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
}
