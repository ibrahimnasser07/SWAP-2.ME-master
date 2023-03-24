import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.iconData,
  });

  final String title;
  final void Function() onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadowColor: Colors.transparent,
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(color: Colors.black54),
          ),
          onTap: onTap,
          leading: Icon(iconData),
        ),
      ),
    );
  }
}