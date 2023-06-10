import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/players.dart';

class DeleteDialog extends StatefulWidget {
  final String title;
  final String content;
  final String username;

  DeleteDialog(this.title, this.content, this.username);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  void _deletePlayer(String username) {
    var player =
        Provider.of<Players>(context, listen: false).findByUsername(username);
    Provider.of<Players>(context, listen: false).deletePlayer(player.play_id);
    Provider.of<Players>(context, listen: false).readAllManagePlayer();
    Provider.of<Players>(context, listen: false).readAllQueryPlayer();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.content),
      actions: [
        TextButton(
          onPressed: () {
            _deletePlayer(widget.username);
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
