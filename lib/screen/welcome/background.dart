import 'package:flutter/material.dart';
import '../../utils/image_constants.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageConstants.welcome_icon,
      height: 300,
      width: double.infinity,
    );
  }
}
