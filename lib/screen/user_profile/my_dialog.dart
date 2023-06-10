import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function logoutUser;

  MyDialog(this.title, this.content, this.logoutUser);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: logoutUser,
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('No'),
        )
      ],
    );
  }
}
