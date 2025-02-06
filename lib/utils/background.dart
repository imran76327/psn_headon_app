import 'package:flutter/material.dart';

import 'theme/theme_notifier.dart';

class background extends StatelessWidget {
  const background({
    super.key,
    required this.themeNotifier,
  });

  final ThemeNotifier themeNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: themeNotifier.isDarkMode == true
            ? const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/back_balls_dark.png")))
            : const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/back_balls_light.png")))
        // : const BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topRight,
        //       end: Alignment.bottomLeft,
        //       colors: [
        //         Color.fromARGB(255, 242, 248, 242),
        //         Color.fromARGB(255, 178, 182, 178),
        //       ],
        //     ),
        //   ),
        );
  }
}
