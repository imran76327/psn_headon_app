import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/theme/theme_notifier.dart';



class BuildCard extends StatefulWidget {
  const BuildCard({
    super.key,
    required this.context,
    required this.number,
    required this.title,
    required this.color,
    required this.onTap,
    required this.type,
  });

  final BuildContext context;
  final String number;
  final String title;
  final Color color;
  final VoidCallback onTap;
  final String type;

  @override
  State<BuildCard> createState() => _BuildCardState();
}

class _BuildCardState extends State<BuildCard> with SingleTickerProviderStateMixin {
  double _elevation = 10;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeat animation back and forth

    _animation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 0.3))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    setState(() {
      _elevation = 0;
    });

    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _elevation = 10;
      });
    });

    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);  // Fixing the theme access
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamically adjust size based on screen width
    double cardSize = screenWidth * 0.44; // Adjusts card size to 44% of screen width

    // Get the widget based on the type (icon or image)
    Widget iconOrImage = _getIconOrImage(cardSize, themeNotifier);

    return GestureDetector(
      onTap: _onTap,
      child: Material(
        elevation: _elevation,
        shadowColor: themeNotifier.isDarkMode
            ? Colors.red.shade900
            : const Color.fromARGB(255, 233, 233, 233),  // Correct theme access
        color: widget.color, // Apply white background in dark mode, else original color
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: SizedBox(
          height: cardSize,
          width: cardSize,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Display the corresponding icon or image based on the type
                iconOrImage,
                // Number below the icon/image
                Center(
                  child: _buildText(widget.number, cardSize * 0.1),
                ),
                // Title below the number
                Center(
                  child: _buildText(widget.title, cardSize * 0.1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Get the correct icon or image widget based on the type
  Widget _getIconOrImage(double cardSize, ThemeNotifier themeNotifier) {
    switch (widget.type.toLowerCase()) {
      case 'slot':
        return Image.asset(
          'assets/gif/worked.gif',  // Slot GIF
          width: cardSize * 0.4, // Adjust image size
          height: cardSize * 0.4,
        );
      case 'attend':
        return Image.asset(
          'assets/gif/calender.gif',  // Attendance GIF
          width: cardSize * 0.4, // Adjust image size
          height: cardSize * 0.4,
        );
      case 'wage':
        return Image.asset(
          'assets/gif/salary.gif',  // Wage GIF
          width: cardSize * 0.4,     // Adjust image size
          height: cardSize * 0.4,
          color: themeNotifier.isDarkMode ? Colors.red.shade900 : null, // Apply red color in dark mode, else default
        );

      case 'utr':
        return Image.asset(
          'assets/gif/utr.gif',  // UTR GIF
          width: cardSize * 0.4,  // Adjust image size
          height: cardSize * 0.4,
          color: themeNotifier.isDarkMode ? Colors.red.shade900 : null, // Apply red color in dark mode, else default
        );

      default:
        return Image.asset(
          'assets/gif/slot.gif',  // Default GIF
          width: cardSize * 0.4, // Adjust image size
          height: cardSize * 0.4,
          color: themeNotifier.isDarkMode ? Colors.red.shade900 : null, // Default behavior based on theme
        );
    }
  }

  Widget _buildText(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.red.shade900,
      ),
    );
  }
}
