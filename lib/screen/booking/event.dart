import 'package:flutter/material.dart';

class Event extends StatelessWidget {
  dynamic event;

  Event(this.event);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 20,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            border: Border.all(color: Colors.grey)),
        child: Center(
            child: Text(
          event,
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
        )),
      ),
    );
  }
}
