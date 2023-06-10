import 'package:court_endah/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';
import '../../models/create_booking.dart';

class ConfirmBooking extends StatelessWidget {
  final Function saveBooking;
  final Function createBooking;
  CreateBooking editedBooking;

  ConfirmBooking(this.saveBooking, this.createBooking, this.editedBooking);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
      child: ElevatedButton(
        onPressed: () {
          var booking = CreateBooking(
              book_date: editedBooking.book_date,
              book_time: editedBooking.book_time,
              court_id: editedBooking.court_id,
              play_id: editedBooking.play_id,
              book_createdate: DateTime.now().toString(),
              book_active: BookActive.Active);
          createBooking(booking);
          saveBooking();
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: ColorConstants.primaryColor,
          shape: StadiumBorder(),
        ),
        child: Text(
          'Confirm Booking',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
