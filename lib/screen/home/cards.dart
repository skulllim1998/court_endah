import 'package:flutter/material.dart';
import './carditem.dart';

class Cards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Carditem('COURT', '2 courts'),
              SizedBox(height: 20,),
              Carditem('OPEN UNTIL', '10 PM'),
            ],
          ),
          Column(
            children: [
              Carditem('SHOWER AREA', 'Yes'),
              SizedBox(height: 20,),
              Carditem('LEVEL', 'Level 8'),
            ],
          ),
        ],
      ),
    );
  }
}
