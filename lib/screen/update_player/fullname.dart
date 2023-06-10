import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';
import '../../models/update_player.dart';

class Fullname extends StatelessWidget {
  final String fullname;
  final Function updatePlayer;
  UpdatePlayer editedPlayer;

  Fullname(this.fullname, this.updatePlayer, this.editedPlayer);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: TextFormField(
        initialValue: fullname,
        style: GoogleFonts.nunito(
          fontSize: 20,
        ),
        cursorColor: ColorConstants.primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            Icons.person_2_outlined,
            color: ColorConstants.primaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.primaryColor),
          ),
          hintText: 'Fullname',
          hintStyle: GoogleFonts.nunito(
            fontSize: 20,
          ),
        ),
        onSaved: (newValue) {
          var player = UpdatePlayer(
              play_password: editedPlayer.play_password,
              play_fullname: newValue,
              play_unitno: editedPlayer.play_unitno,
              play_cardno: editedPlayer.play_cardno,
              play_createdate: editedPlayer.play_createdate,
              play_active: editedPlayer.play_active);
          updatePlayer(player);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter a fullname.';
          }
          return null;
        },
      ),
    );
  }
}
