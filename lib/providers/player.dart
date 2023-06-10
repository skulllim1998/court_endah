import 'package:flutter/foundation.dart';

enum PlayActive {
  Inactive,
  Active,
}

class Player with ChangeNotifier {
  final int play_id;
  final String play_username;
  String play_password;
  String play_fullname;
  String play_unitno;
  String play_cardno;
  String play_createdate;
  PlayActive play_active;

  Player({
    @required this.play_id,
    @required this.play_username,
    @required this.play_password,
    @required this.play_fullname,
    @required this.play_unitno,
    @required this.play_cardno,
    @required this.play_createdate,
    @required this.play_active,
  });
}
