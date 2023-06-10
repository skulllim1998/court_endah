import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';
import '../../models/update_player.dart';

class Unitno extends StatelessWidget {
  final String unitno;
  final Function updatePlayer;
  UpdatePlayer editedPlayer;

  Unitno(this.unitno, this.updatePlayer, this.editedPlayer);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: TextFormField(
        initialValue: unitno,
        style: GoogleFonts.nunito(
          fontSize: 20,
        ),
        cursorColor: ColorConstants.primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            Icons.numbers,
            color: ColorConstants.primaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.primaryColor),
          ),
          hintText: 'Unit No',
          hintStyle: GoogleFonts.nunito(
            fontSize: 20,
          ),
        ),
        onSaved: (newValue) {
          var player = UpdatePlayer(
              play_password: editedPlayer.play_password,
              play_fullname: editedPlayer.play_fullname,
              play_unitno: newValue[0].toUpperCase() + newValue.substring(1, 5),
              play_cardno: editedPlayer.play_cardno,
              play_createdate: editedPlayer.play_createdate,
              play_active: editedPlayer.play_active);
          updatePlayer(player);
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
