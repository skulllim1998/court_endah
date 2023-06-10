import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Validatetext extends StatelessWidget {
  final String displayedText;

  Validatetext(this.displayedText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //margin: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: Text(
        displayedText,
        style: GoogleFonts.nunito(
          fontSize: 16,
          color: Colors.red,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
