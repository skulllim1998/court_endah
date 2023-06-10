import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/color_constants.dart';

class Login extends StatelessWidget {
  final Function navigateLoginScreen;

  Login(this.navigateLoginScreen);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      child: TextButton(
        onPressed: navigateLoginScreen,
        child: Text(
          'Already a member? Log in',
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
