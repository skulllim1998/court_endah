import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';
import '../../models/login_player.dart';

class Username extends StatelessWidget {
  final Function loginPlayer;
  LoginPlayer editedPlayer;

  Username(this.loginPlayer, this.editedPlayer);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      margin: EdgeInsets.all(20),
      child: TextFormField(
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.people,
            color: ColorConstants.primaryColor,
          ),
          //border: InputBorder.none,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          hintText: 'Username',
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
            newValue,
            editedPlayer.play_password,
          );
          loginPlayer(player);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter an username.';
          }
          return null;
        },
      ),
    );
  }
}
