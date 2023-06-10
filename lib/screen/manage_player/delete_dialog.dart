import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function deleteBooking;
  final String username;

  DeleteDialog(this.title, this.content, this.deleteBooking, this.username);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            deleteBooking(username);
            //Navigator.pop(context);
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
