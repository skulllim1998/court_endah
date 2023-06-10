import 'package:flutter/foundation.dart';

class UpdateBooking {
  String book_date;
  String book_time;
  int court_id;
  int play_id;

  UpdateBooking({
    @required this.book_date,
    @required this.book_time,
    @required this.court_id,
    @required this.play_id,
  });
}
