import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function deleteBooking;
  final int index;

  MyDialog(this.title, this.content, this.deleteBooking, this.index);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            deleteBooking(index);
            Navigator.pop(context);
          },
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
