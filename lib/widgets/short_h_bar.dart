import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

class ShortHBar extends StatelessWidget {
  const ShortHBar({
    super.key,
    this.height,
    this.width,
    this.color,
  });

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 4,
      width: width ?? 25,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: color ?? TColors.darkGrey.withOpacity(.2),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
