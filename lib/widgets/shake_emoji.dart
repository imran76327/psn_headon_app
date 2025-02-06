import 'package:flutter/material.dart';

class ShakingEmoji extends StatefulWidget {
  final String emoji;
  final double height;

  const ShakingEmoji({super.key, 
    required this.emoji,
    this.height = 20.0,
  });

  @override
  _ShakingEmojiState createState() => _ShakingEmojiState();
}

class _ShakingEmojiState extends State<ShakingEmoji>
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
        return Transform.translate(
          offset: Offset(
            _controller.value * 3.0, // Adjust the multiplier for intensity
            0,
          ),
          child: Text.rich(
            TextSpan(
              text: widget.emoji,
              style: TextStyle(fontSize: widget.height),
            ),
          ),
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
