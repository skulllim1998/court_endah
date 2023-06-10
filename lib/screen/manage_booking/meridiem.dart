import 'package:flutter/material.dart';

class Meridiem extends StatelessWidget {
  final String meridiemChoose;
  final List<String> meridiemItems;
  final Function setMeridiemChoose;

  Meridiem(this.meridiemChoose, this.meridiemItems, this.setMeridiemChoose);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      itemHeight: 50,
      hint: Text('Select Items:'),
      value: meridiemChoose,
      onChanged: (newValue) {
        setMeridiemChoose(newValue);
      },
      items: meridiemItems.map((valueItem) {
        return DropdownMenuItem(
          value: valueItem,
          child: Text(valueItem),
        );
      }).toList(),
    );
  }
}
