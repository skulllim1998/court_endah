import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/player.dart';
import '../../utils/color_constants.dart';
import './delete_dialog.dart';
import '../update_player/update_player_screen.dart';
import '../../providers/players.dart';

class PlayerItem extends StatefulWidget {
  final Player player;
  final int index;

  PlayerItem(this.player, this.index);

  @override
  State<PlayerItem> createState() => _PlayerItemState();
}

class _PlayerItemState extends State<PlayerItem> {
  void _deletePlayer(String username) {
    var player =
        Provider.of<Players>(context, listen: false).findByUsername(username);
    Provider.of<Players>(context, listen: false).deletePlayer(player.play_id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(
            widget.player.play_username,
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                widget.player.play_fullname,
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: ColorConstants.grey,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdatePlayerScreen(
                          widget.player.play_username,
                        ),
                      ));
                },
                icon: Icon(
                  Icons.edit,
                  color: ColorConstants.primaryColor,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
