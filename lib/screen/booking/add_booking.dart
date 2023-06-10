import 'package:flutter/material.dart';

class AddBooking extends StatelessWidget {
  final Function showAddDialog;

  AddBooking(this.showAddDialog);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      child: Icon(Icons.add),
      onPressed: showAddDialog,
    );
  }
}
