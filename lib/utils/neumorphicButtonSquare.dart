import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class NeumorphicButtonSquare extends StatelessWidget {
  const NeumorphicButtonSquare({
    super.key,
    required this.size,
    this.child,
    this.onPressed,
    this.blur = 20,
    this.distance = 10,
    this.colors,
    this.imgUrl,
    this.padding,
  });
  final double size;
  final double? padding;
  final Widget? child;
  final VoidCallback? onPressed;
  final double blur;
  final double distance;
  final List<Color>? colors;
  final String? imgUrl;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size,
        width: size,
        padding: EdgeInsets.all(padding ?? 6),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          // color: colors == null
          //     ? imgUrl != null
          //         ? Theme.of(context).colorScheme.primary
          //         : Theme.of(context).colorScheme.background
          //     : colors![1],
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.surface,
              blurRadius: blur,
              // inset: true,
              offset: Offset(distance, distance),
            ),
            BoxShadow(
              color: Theme.of(context).colorScheme.onSurface,
              blurRadius: blur,
              offset: Offset(-distance, -distance),

              // inset: true,
            )
          ],
        ),
        child: imgUrl != null
            ? Image.asset(
                imgUrl!,
                fit: BoxFit.fill,
              )
            : Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Theme.of(context).colorScheme.surface,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: colors ??
                        [
                          Theme.of(context).colorScheme.surface,
                          Theme.of(context).colorScheme.onSurface,
                        ],
                  ),
                ),
                child: child,
              ),
      ),
    );
  }
}
