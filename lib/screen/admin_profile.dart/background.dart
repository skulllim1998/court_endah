import 'package:flutter/material.dart';
import '../../utils/image_constants.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Image.asset(
        ImageConstants.profile_icon,
        height: 150,
        width: double.infinity,
      ),
    );
  }
}
