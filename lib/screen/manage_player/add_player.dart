import 'package:flutter/material.dart';

import '../../utils/color_constants.dart';
import '../../providers/player.dart';
import '../add_player/add_player_screen.dart';

class AddPlayer extends StatelessWidget {
  final Function navigateScreen;

  AddPlayer(this.navigateScreen);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorConstants.primaryColor,
      child: Icon(Icons.add),
      onPressed: navigateScreen,
    );
  }
}
