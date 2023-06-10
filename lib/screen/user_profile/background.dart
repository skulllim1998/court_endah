import 'package:flutter/material.dart';
import '../../utils/image_constants.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageConstants.profile_icon,
      height: 150,
      width: double.infinity,
    );
  }
}
