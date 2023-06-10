import 'package:flutter/material.dart';

import '../../models/filter_player.dart';

class DateItem extends StatelessWidget {
  final Function filterPlayer;
  final FilterPlayer editedPlayer;

  DateItem(this.filterPlayer, this.editedPlayer);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 100,
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Year',
                  hintText: 'Year'),
              onSaved: (newValue) {
                var player = FilterPlayer(
                    play_block: editedPlayer.play_block,
                    play_level: editedPlayer.play_level,
                    play_year: newValue,
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 100,
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Month',
                  hintText: 'Month'),
              onSaved: (newValue) {
                var player = FilterPlayer(
                    play_block: editedPlayer.play_block,
                    play_level: editedPlayer.play_level,
                    play_year: editedPlayer.play_year,
                    play_month: newValue,
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
        ),
      ],
    );
  }
}
