import 'package:flutter/material.dart';

class AddEvent extends StatelessWidget {
  TextEditingController eventController;
  Function addEvent;

  AddEvent(this.eventController, this.addEvent);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white70,
      title: Text("Add Events"),
      content: TextField(
        controller: eventController,
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            "Save",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            if (eventController.text.isEmpty) return;
            addEvent();
          },
        )
      ],
    );
  }
}
