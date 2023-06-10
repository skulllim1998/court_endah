import 'package:flutter/foundation.dart';

import './booking.dart';

class CreateBooking {
  String book_date;
  String book_time;
  int court_id;
  int play_id;
  String book_createdate;
  BookActive book_active;

  CreateBooking({
    @required this.book_date,
    @required this.book_time,
    @required this.court_id,
    @required this.play_id,
    @required this.book_createdate,
    @required this.book_active,
  });
}
