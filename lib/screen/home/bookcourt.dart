import 'package:flutter/material.dart';
import '../../utils/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../providers/login_pref.dart';

class Bookcourt extends StatelessWidget {
  final Function navigateScreen;

  Bookcourt(this.navigateScreen);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      margin: EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: navigateScreen,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: ColorConstants.primaryColor,
          shape: StadiumBorder(),
        ),
        child: Text(
          'Book Court',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
