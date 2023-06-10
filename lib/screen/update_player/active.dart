import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../utils/color_constants.dart';
import './my_dialog.dart';
import '../../providers/players.dart';
import './active_dialog.dart';

class Active extends StatefulWidget {
  final String username;

  Active(this.username);

  @override
  State<Active> createState() => _ActiveState();
}

class _ActiveState extends State<Active> {
  void _activePlayer(String username) {
    var player =
        Provider.of<Players>(context, listen: false).findByUsername(username);
    Provider.of<Players>(context, listen: false).activePlayer(player.play_id);
    Provider.of<Players>(context, listen: false).readAllManagePlayer();
    Provider.of<Players>(context, listen: false).readAllQueryPlayer();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: ElevatedButton(
        onPressed: () {
          Future.delayed(Duration.zero, () async {
            showDialog(
              context: context,
              builder: (ctx) => ActiveDialog(
                  'Active Player',
                  'Are you sure you want to active?',
                  _activePlayer,
                  widget.username),
            );
          });
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: ColorConstants.primaryColor,
          shape: StadiumBorder(),
        ),
        child: Text(
          'Active Profile',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
