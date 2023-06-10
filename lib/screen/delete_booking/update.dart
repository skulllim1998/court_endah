import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';

class Update extends StatelessWidget {
  final Function navigateScreen;

  Update(this.navigateScreen);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: ElevatedButton(
        onPressed: navigateScreen,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: ColorConstants.primaryColor,
          shape: StadiumBorder(),
        ),
        child: Text(
          'Update Booking',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
