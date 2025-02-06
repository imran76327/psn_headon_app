import 'dart:math';

import 'package:flutter/material.dart';

class BottomLeftArrow extends StatelessWidget {
  const BottomLeftArrow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 320 * pi / 180,
      child: const IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: null,
      ),
    );
  }
}


// Transform(
//       child: Icon(
//         Icons.arrow_back,
//         size: 30,
//         color: Colors.white,
//       ),
//       transform: new Matrix4.identity()..rotateZ(320 * 3.14 / 180),
//     );


// Transform(
//       child: Icon(
//         Icons.arrow_back,
//         size: 30,
//         color: Colors.white,
//       ),
//       transform: new Matrix4.identity()..rotateZ(150 * 3.14 / 180),
//     );