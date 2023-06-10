import 'package:flutter/material.dart';

class ActiveDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function activePlayer;
  final String username;

  ActiveDialog(this.title, this.content, this.activePlayer, this.username);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            activePlayer(username);
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
