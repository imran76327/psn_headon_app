// import 'package:attendance_management/common/models/rive_asset.dart';
// import 'package:attendance_management/common/utils/coloors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'shake_emoji.dart';
// import 'package:rive/rive.dart';
// import 'package:flutter/animation.dart';

class NavTop extends StatelessWidget {
  const NavTop(
      {super.key,
      required this.name,
      required this.profession,
      required this.greetings});

  final String name, profession, greetings;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // tileColor: Theme.of(context).colorScheme.primary,
      tileColor: Colors.transparent,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          CupertinoIcons.person,
          color: Theme.of(context).colorScheme.onSurface,
          size: 35,
        ),
      ),
      title: Text(
        "Hi $name ",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Row(
        children: [
          Text(
            "Have A Good Day!!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 8), // Add some space between the icon and text
          const ShakingEmoji(
            emoji: "👋",
            height: 25,
          ),
        ],
      ),
    );
  }
}
