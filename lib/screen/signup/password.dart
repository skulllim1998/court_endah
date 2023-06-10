import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';
import '../../models/create_player.dart';

class Password extends StatelessWidget {
  final Function createPlayer;
  CreatePlayer editedPlayer;

  Password(this.createPlayer, this.editedPlayer);

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
            height: 0.1,
          ),
        ),
        onSaved: (newValue) {
          var player = CreatePlayer(
              play_username: editedPlayer.play_username,
              play_password: newValue,
              play_fullname: editedPlayer.play_fullname,
              play_unitno: editedPlayer.play_unitno,
              play_cardno: editedPlayer.play_cardno,
              play_createdate: editedPlayer.play_createdate,
              play_active: editedPlayer.play_active);
          createPlayer(player);
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
