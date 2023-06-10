import 'package:flutter/material.dart';
import '../../utils/image_constants.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        ImageConstants.home_background,
        fit: BoxFit.cover,
      ),
    );
  }
}
