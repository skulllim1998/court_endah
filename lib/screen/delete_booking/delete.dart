import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/color_constants.dart';

class Delete extends StatelessWidget {
  final Function deleteBooking;

  Delete(this.deleteBooking);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      margin: EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: deleteBooking,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.redAccent,
          shape: StadiumBorder(),
        ),
        child: Text(
          'Cancel Booking',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
