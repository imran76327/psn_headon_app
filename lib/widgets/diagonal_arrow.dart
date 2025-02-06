import 'package:flutter/material.dart';

class DiagonalArrowIcon extends StatelessWidget {
  const DiagonalArrowIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40, // Adjust width as needed
      height: 40, // Adjust height as needed
      child: CustomPaint(
        painter: DiagonalArrowPainter(),
      ),
    );
  }
}

class DiagonalArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black // Arrow color
      ..strokeWidth = 2.0 // Arrow line width
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, 0),
      paint,
    );

    // Add an arrowhead
    double arrowSize = 5.0; // Adjust arrowhead size
    paint.strokeWidth = 1.0;
    canvas.drawLine(
      Offset(size.width - arrowSize, arrowSize),
      Offset(size.width, 0),
      paint,
    );

    canvas.drawLine(
      Offset(arrowSize, size.height - arrowSize),
      Offset(0, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
