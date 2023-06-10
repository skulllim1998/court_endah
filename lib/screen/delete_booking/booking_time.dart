import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';

class BookingTime extends StatelessWidget {
  final String bookTime;

  BookingTime(this.bookTime);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(5),
        child: ListTile(
          leading: Icon(
            Icons.calendar_month,
            color: ColorConstants.primaryColor,
          ),
          title: Text(
            'Time',
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            bookTime,
            style: GoogleFonts.nunito(
              fontSize: 18,
              color: ColorConstants.grey,
            ),
          ),
        ),
      )),
    );
  }
}
