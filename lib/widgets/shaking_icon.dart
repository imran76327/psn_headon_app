import 'dart:math';

import 'package:flutter/material.dart';

class ShakingIcon extends StatefulWidget {
  final IconData? icon;
  final String? imageAssetPath;
  final String buttonText;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final bool? mirror;

  const ShakingIcon({super.key, 
    this.icon,
    this.imageAssetPath,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor,
    this.mirror,
  });

  @override
  _ShakingIconState createState() => _ShakingIconState();
}

class _ShakingIconState extends State<ShakingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Column(
          children: [
            Transform.translate(
              offset: Offset(
                _controller.value * 3.0, // Adjust the multiplier for intensity
                0,
              ),
              child: ElevatedButton(
                onPressed: widget.onPressed,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: widget.mirror == true
                      ? const EdgeInsets.all(3.0)
                      : const EdgeInsets.all(16.0),
                  backgroundColor: widget.buttonColor ?? Colors.blue,
                  // Use the provided color or fallback to blue
                ),
                child: widget.icon != null
                    ? widget.mirror == true
                        ? Transform.rotate(
                            angle: 180 * pi / 180,
                            child: const IconButton(
                              icon: Icon(
                                Icons.brightness_3,
                                color: Colors.white,
                              ),
                              iconSize: 40,
                              onPressed: null,
                            ),
                          )
                        : Icon(
                            widget.icon,
                            size: 30,
                            color: Colors.white,
                          )
                    : widget.imageAssetPath != null
                        ? Image.asset(
                            widget.imageAssetPath!,
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          )
                        : const SizedBox(),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              widget.buttonText,
              textAlign: TextAlign.center, // Center the text
              style:
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
