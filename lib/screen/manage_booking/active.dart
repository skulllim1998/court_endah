import 'package:flutter/material.dart';

class Active extends StatelessWidget {
  final String valueChoose;
  final List<String> listItem;
  final Function setValueChoose;

  Active(this.valueChoose, this.listItem, this.setValueChoose);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      itemHeight: 50,
      hint: Text('Select Items:'),
      value: valueChoose,
      onChanged: (newValue) {
        setValueChoose(newValue);
      },
      items: listItem.map((valueItem) {
        return DropdownMenuItem(
          value: valueItem,
          child: Text(valueItem),
        );
      }).toList(),
    );
  }
}
