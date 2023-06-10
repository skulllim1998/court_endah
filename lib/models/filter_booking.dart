import 'package:flutter/foundation.dart';

class FilterBooking {
  String book_year;
  String book_month;
  String book_meridiem;
  String book_court;
  String book_active;

  FilterBooking({
    @required this.book_year,
    @required this.book_month,
    @required this.book_meridiem,
    @required this.book_court,
    @required this.book_active,
  });
}
