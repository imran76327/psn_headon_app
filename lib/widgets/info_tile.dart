import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({super.key, required this.name, required this.profession});

  final String name, profession;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Icon(
          CupertinoIcons.person,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      subtitle: Text(
        profession,
        style: TextStyle(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
