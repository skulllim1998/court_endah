import 'package:flutter/material.dart';
import '../../utils/color_constants.dart';

class Back extends StatelessWidget {
  void test() => print('');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.all(30),
      child: ElevatedButton(
        onPressed: test,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: ColorConstants.backgroundColor,
        ),
        child: Icon(
          Icons.arrow_back,
          color: ColorConstants.primaryColor,
        ),
      ),
    );
  }
}
