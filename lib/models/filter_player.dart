import 'package:flutter/foundation.dart';

class FilterPlayer {
  String play_block;
  String play_level;
  String play_year;
  String play_month;
  String play_active;

  FilterPlayer({
    @required this.play_block,
    @required this.play_level,
    @required this.play_year,
    @required this.play_month,
    @required this.play_active,
  });
}
