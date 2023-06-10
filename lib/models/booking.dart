import 'package:flutter/foundation.dart';

enum BookActive {
  Inactive,
  Active,
}

class Booking {
  int book_id;
  String book_date;
  String book_time;
  int court_id;
  int play_id;
  String book_createdate;
  BookActive book_active;

  Booking({
    @required this.book_id,
    @required this.book_date,
    @required this.book_time,
    @required this.court_id,
    @required this.play_id,
    @required this.book_createdate,
    @required this.book_active,
  });
}
