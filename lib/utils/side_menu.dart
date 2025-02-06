import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    super.key,
    required this.isSidebarOpen,
    required this.size,
    required this.body,
    required this.right,
  });
  final bool isSidebarOpen;
  final Size size;
  final Widget body;
  final bool right;
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return widget.right == true
        ? AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            right: widget.isSidebarOpen ? 0 : -widget.size.width * 0.8,
            top: 0,
            bottom: 0,
            child: GlassmorphicContainer(
                width: widget.size.width * 0.8,
                height: widget.size.height,
                borderRadius: 20,
                blur: 5,
                // alignment: Alignment.bottomCenter,
                border: 2,
                linearGradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    // Theme.of(context).colorScheme.secondary.withOpacity(1),
                    // Theme.of(context).colorScheme.surface.withOpacity(1),
                    Theme.of(context).colorScheme.surface.withOpacity(0.9),
                    Theme.of(context).colorScheme.surface.withOpacity(0.9),
                  ],
                ),
                borderGradient: LinearGradient(
                  colors: [
                    const Color(0xFFffffff).withOpacity(1),
                    const Color((0xFFFFFFFF)).withOpacity(0.3),
                  ],
                ),
                child: widget.body),
          )
        : AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: 0,
            bottom: 0,
            left: widget.isSidebarOpen ? 0 : -widget.size.width * 0.8,
            child: GlassmorphicContainer(
                width: widget.size.width * 0.8,
                height: widget.size.height,
                borderRadius: 20,
                blur: 5,
                // alignment: Alignment.bottomCenter,
                border: 2,
                linearGradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    // Theme.of(context).colorScheme.secondary.withOpacity(1),
                    // Theme.of(context).colorScheme.surface.withOpacity(1),
                    Theme.of(context).colorScheme.surface.withOpacity(0.9),
                    Theme.of(context).colorScheme.surface.withOpacity(0.9),
                  ],
                ),
                borderGradient: LinearGradient(
                  colors: [
                    const Color(0xFFffffff).withOpacity(1),
                    const Color((0xFFFFFFFF)).withOpacity(0.3),
                  ],
                ),
                child: widget.body),
          );
  }
}
