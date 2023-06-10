import 'package:flutter/material.dart';

import '../../utils/image_constants.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Image.asset(
        ImageConstants.signup_icon,
        height: 250,
        width: double.infinity,
      ),
    );
  }
}
