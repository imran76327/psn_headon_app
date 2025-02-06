import 'dart:math';

import 'package:flutter/material.dart';

class TopRightArrow extends StatelessWidget {
  const TopRightArrow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 140 * pi / 180,
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
