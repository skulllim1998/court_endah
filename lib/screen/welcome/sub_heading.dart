import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/color_constants.dart';

class Sub_Heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text(
        'Challenge your friend and play \ntogether a game of badminton.',
        style: GoogleFonts.nunito(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorConstants.grey,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
