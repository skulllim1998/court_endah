import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';
import '../../models/update_admin.dart';

class Password extends StatelessWidget {
  final String password;
  final Function updateAdmin;
  UpdateAdmin editedAdmin;

  Password(this.password, this.updateAdmin, this.editedAdmin);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: TextFormField(
        obscureText: true,
        initialValue: password,
        style: GoogleFonts.nunito(
          fontSize: 20,
        ),
        cursorColor: ColorConstants.primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            Icons.password_rounded,
            color: ColorConstants.primaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.primaryColor),
          ),
          hintText: 'Password',
          hintStyle: GoogleFonts.nunito(
            fontSize: 20,
          ),
        ),
        onSaved: (newValue) {
          var admin = UpdateAdmin(admin_password: newValue);
          updateAdmin(admin);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter a password.';
          }
          return null;
        },
      ),
    );
  }
}
