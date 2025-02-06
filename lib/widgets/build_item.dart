import 'package:flutter/material.dart';

import '../utils/neumorphicButton.dart';

class BuildItem extends StatelessWidget {
  const BuildItem({
    super.key,
    required this.context,
    required this.icon,
    required this.label,
  });

  final BuildContext context;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: NeumorphicButton(
              size: 60,
              distance: 5,
              blur: 15,
              padding: 3,
              paddingColor: const Color.fromARGB(255, 220, 216, 216),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(width: 10),
          RichText(
            text: TextSpan(
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5),
              text: label,
            ),
          ),
        ],
      ),
    );
  }
}
