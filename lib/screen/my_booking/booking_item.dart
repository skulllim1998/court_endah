import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';
import '../../models/booking.dart';
import './my_dialog.dart';

class BookingItem extends StatelessWidget {
  final List<Booking> myBookings;
  final int index;
  final List<String> myCourtType;
  final Function deleteBooking;

  BookingItem(
      this.myBookings, this.index, this.myCourtType, this.deleteBooking);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(
            myBookings[index].book_date,
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                myBookings[index].book_time + ' | ',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: ColorConstants.grey,
                ),
              ),
              Text(
                myCourtType[index],
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: ColorConstants.grey,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () {
              Future.delayed(Duration.zero, () async {
                showDialog(
                  context: context,
                  builder: (ctx) => MyDialog('Cancel Booking',
                      'Are you sure you want to cancel?', deleteBooking, index),
                );
              });

              //deleteBooking();
            },
            icon: Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
          ),
        ),
      )),
    );
  }
}
