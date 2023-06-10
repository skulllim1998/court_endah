import 'package:court_endah/models/login_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/color_constants.dart';

class Password extends StatelessWidget {
  final Function loginPlayer;
  LoginPlayer editedPlayer;

  Password(this.loginPlayer, this.editedPlayer);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      //margin: EdgeInsets.all(20),
      child: TextFormField(
        obscureText: true,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.password_rounded,
            color: ColorConstants.primaryColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          hintText: 'Password',
          hintStyle: GoogleFonts.nunito(),
          fillColor: ColorConstants.light_green,
          filled: true,
          errorStyle: TextStyle(
            fontSize: 16,
            height: 0.1,
          ),
        ),
        onSaved: (newValue) {
          var player = LoginPlayer(
            editedPlayer.play_username,
            newValue,
          );
          loginPlayer(player);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter an password.';
          }
          return null;
        },
      ),
    );
  }
}
