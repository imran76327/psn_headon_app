import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({
    super.key,
    required this.press,
    required this.riveOnInit,
    required this.isSideMenuClosedcheck,
  });
  final VoidCallback press;
  final bool isSideMenuClosedcheck;
  final ValueChanged<Artboard> riveOnInit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: const EdgeInsets.only(left: 0),
          height: 40,
          width: 30,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: isSideMenuClosedcheck ? BoxShape.rectangle : BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onSurface,
                offset: const Offset(0, 3),
                blurRadius: 8,
              )
            ],
          ),
          child: RiveAnimation.asset(
            "assets/RiveAssets/menu_button.riv",
            onInit: riveOnInit,
          ),
        ),
      ),
    );
  }
}
