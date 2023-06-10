import 'package:flutter/material.dart';
import '../../utils/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import './heading.dart';
import './paragraph.dart';
import './cards.dart';
import './bookcourt.dart';

class Content extends StatelessWidget {
  final Function navigateScreen;

  Content(this.navigateScreen);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.backgroundColor,
        //border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Heading(),
          Paragraph(),
          Cards(),
          Bookcourt(navigateScreen),
        ],
      ),
    );
  }
}
