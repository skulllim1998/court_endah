import 'package:flutter/material.dart';

import '../../models/filter_player.dart';

class Level extends StatelessWidget {
  final Function filterPlayer;
  final FilterPlayer editedPlayer;

  Level(this.filterPlayer, this.editedPlayer);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 100,
        child: TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Level',
              hintText: 'Level'),
          onSaved: (newValue) {
            var player = FilterPlayer(
                play_block: editedPlayer.play_block,
                play_level: newValue,
                play_year: editedPlayer.play_year,
                play_month: editedPlayer.play_month,
                play_active: editedPlayer.play_active);
            filterPlayer(player);
          },
          validator: (value) {
            if (value.isEmpty) {
              return null;
            }
            try {
              int.parse(value);
            } catch (error) {
              return 'Integer only.';
            }
            return null;
          },
        ),
      ),
    );
  }
}
