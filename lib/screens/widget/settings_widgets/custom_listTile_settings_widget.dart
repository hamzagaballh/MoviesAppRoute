import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomListtileSettingsWidget extends StatelessWidget {
  CustomListtileSettingsWidget(
      {required this.title, required this.trailing, super.key});

  String title;
  Widget trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 22),
      ),
      trailing: trailing,
    );
  }
}
