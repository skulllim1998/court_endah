import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';
import '../../models/create_player.dart';

class Unitno extends StatelessWidget {
  final Function createPlayer;
  CreatePlayer editedPlayer;

  Unitno(this.createPlayer, this.editedPlayer);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: TextFormField(
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.numbers,
            color: ColorConstants.primaryColor,
          ),
          //border: InputBorder.none,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          hintText: 'Unit No',
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
              play_password: editedPlayer.play_password,
              play_fullname: editedPlayer.play_fullname,
              play_unitno: newValue[0].toUpperCase() + newValue.substring(1, 5),
              play_cardno: editedPlayer.play_cardno,
              play_createdate: editedPlayer.play_createdate,
              play_active: editedPlayer.play_active);
          createPlayer(player);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter an unit number.';
          }
          if (value.length < 5) {
            return 'Not less than 5 characters.';
          }
          if (value.length > 5) {
            return 'Not more than 5 characters.';
          }
          if (value[0] == 'c' ||
              value[0] == 'C' ||
              value[0] == 'd' ||
              value[0] == 'D') {
          } else {
            return 'Wrong format. E.g C1234';
          }
          try {
            int.parse(value.substring(1, 3));
            int.parse(value.substring(3, 5));
          } catch (error) {
            return 'Wrong format. E.g D1234';
          }
          return null;
        },
      ),
    );
  }
}
