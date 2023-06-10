import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';
import '../../models/update_booking.dart';

class Time extends StatelessWidget {
  final String availableTime;
  final Function updateBooking;
  UpdateBooking editedBooking;
  final Function setTimeClick;
  final String timeClick;
  final Function setIsValid;

  Time(this.availableTime, this.updateBooking, this.editedBooking,
      this.setTimeClick, this.timeClick, this.setIsValid);

  @override
  Widget build(BuildContext context) {
    return timeClick == availableTime
        ? InkWell(
            onTap: () {
              setTimeClick(availableTime);
              var booking = UpdateBooking(
                  book_date: editedBooking.book_date,
                  book_time: availableTime,
                  court_id: editedBooking.court_id);
              updateBooking(booking);

              setIsValid(true);
            },
            splashColor: ColorConstants.primaryColor,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Text(
                  availableTime,
                  style: GoogleFonts.nunito(
                    color: ColorConstants.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: ColorConstants.light_green,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: ColorConstants.primaryColor,
                  width: 2.0,
                ),
              ),
            ),
          )
        : InkWell(
            onTap: () {
              setTimeClick(availableTime);

              var booking = UpdateBooking(
                  book_date: editedBooking.book_date,
                  book_time: availableTime,
                  court_id: editedBooking.court_id);
              updateBooking(booking);

              setIsValid(true);
            },
            splashColor: ColorConstants.primaryColor,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Text(
                  availableTime,
                  style: GoogleFonts.nunito(
                    color: ColorConstants.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: ColorConstants.light_green,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
  }
}
