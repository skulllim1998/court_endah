import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/color_constants.dart';

class Signup extends StatelessWidget {
  final Function navigateSignupScreen;

  Signup(this.navigateSignupScreen);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      child: TextButton(
        onPressed: navigateSignupScreen,
        child: Text(
          'Don\'t have an account? Sign Up',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorConstants.grey,
          ),
        ),
      ),
    );
  }
}
