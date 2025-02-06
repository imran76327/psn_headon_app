import 'package:flutter/material.dart';

Container dradient(BuildContext context, double x, double y) {
  return Container(
    decoration: BoxDecoration(
        gradient: RadialGradient(
      colors: [
        Theme.of(context).colorScheme.primary.withOpacity(0.6),
        Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ],
      radius: 0.3,
      stops: const <double>[.8, 0.8],
      center: Alignment(
        x,
        y,
      ),
    )),
  );
}
