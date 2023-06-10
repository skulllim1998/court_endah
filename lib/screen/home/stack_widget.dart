import 'package:flutter/material.dart';
import './background.dart';
import './content.dart';
import './back.dart';

class StackWidget extends StatelessWidget {
  final Function navigateScreen;

  StackWidget(this.navigateScreen);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: 220,
          child: Content(navigateScreen),
        ),
        //Back(),
      ],
    );
  }
}
