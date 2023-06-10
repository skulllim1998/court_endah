import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/color_constants.dart';

class Paragraph extends StatelessWidget {
  var description =
      'With a perfect view around the city, this badminton court is the ideal destination for any fan of this sport.';
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          description,
          style: GoogleFonts.nunito(
            fontSize: 16,
            color: ColorConstants.grey
          ),
          textAlign: TextAlign.justify,
        ));
  }
}
