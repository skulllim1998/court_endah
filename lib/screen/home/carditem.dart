import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/color_constants.dart';

class Carditem extends StatelessWidget {
  final String cardTitle;
  final String cardText;

  Carditem(this.cardTitle, this.cardText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            cardTitle,
            style: GoogleFonts.nunito(
              fontSize: 12,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            cardText,
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
    );
  }
}
