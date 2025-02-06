import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class NeumorphicButton extends StatelessWidget {
  const NeumorphicButton({
    super.key,
    required this.size,
    this.child,
    this.onPressed,
    this.blur = 20,
    this.distance = 10,
    this.colors,
    this.imgUrl,
    this.padding,
    this.paddingColor,
    this.shape = BoxShape.circle,
  });
  final double size;
  final double? padding;
  final Widget? child;
  final VoidCallback? onPressed;
  final double blur;
  final double distance;
  final List<Color>? colors;
  final String? imgUrl;
  final Color? paddingColor;
  final BoxShape? shape;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size,
        width: size,
        padding: EdgeInsets.all(padding ?? 3),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: colors == null
              ? imgUrl != null
                  ? paddingColor ?? Theme.of(context).colorScheme.primary
                  : paddingColor ?? Theme.of(context).colorScheme.surface
              : colors![1],
          shape: shape!,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.surface,
              blurRadius: blur,
              inset: true,
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
            ? CircleAvatar(
                backgroundImage: AssetImage(imgUrl!),
              )
            : Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
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
