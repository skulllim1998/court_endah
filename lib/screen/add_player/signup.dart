import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/color_constants.dart';

class Signup extends StatelessWidget {
  final Function saveForm;

  Signup(this.saveForm);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      margin: EdgeInsets.fromLTRB(20, 0, 29, 20),
      child: ElevatedButton(
        onPressed: saveForm,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: ColorConstants.primaryColor,
          shape: StadiumBorder(),
        ),
        child: Text(
          'Create account',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
