import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/color_constants.dart';

import '../../models/booking.dart';
import '../delete_booking/delete_booking_screen.dart';

class BookingItem extends StatefulWidget {
  final Booking booking;
  final int index;

  BookingItem(this.booking, this.index);

  @override
  State<BookingItem> createState() => _BookingItemState();
}

class _BookingItemState extends State<BookingItem> {
  // void _deletePlayer(String username) {
  //   var player =
  //       Provider.of<Players>(context, listen: false).findByUsername(username);
  //   Provider.of<Players>(context, listen: false).deletePlayer(player.play_id);
  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    return widget.booking.court_id == 1
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  widget.booking.book_date,
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      widget.booking.book_time + ' | ',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        color: ColorConstants.grey,
                      ),
                    ),
                    Text(
                      'Court A',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        color: ColorConstants.grey,
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeleteBookingScreen(
                                widget.booking.book_id,
                              ),
                            ));
                      },
                      icon: Icon(
                        Icons.edit,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            )),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  widget.booking.book_date,
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      widget.booking.book_time + ' | ',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        color: ColorConstants.grey,
                      ),
                    ),
                    Text(
                      'Court B',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        color: ColorConstants.grey,
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeleteBookingScreen(
                                widget.booking.book_id,
                              ),
                            ));
                      },
                      icon: Icon(
                        Icons.edit,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            )),
          );
  }
}
