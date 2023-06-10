import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function navigateScreen;

  MyDialog(this.title, this.content, this.navigateScreen);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: navigateScreen,
          child: Text('Ok'),
        )
      ],
    );
  }
}
