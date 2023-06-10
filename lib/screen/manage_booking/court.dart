import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constants.dart';
import '../../models/filter_booking.dart';

class Court extends StatelessWidget {
  final int isClick;
  final Function setIsClick;
  final Function filterBooking;
  final FilterBooking editedBooking;

  Court(this.isClick, this.setIsClick, this.filterBooking, this.editedBooking);

  @override
  Widget build(BuildContext context) {
    return isClick == 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      setIsClick(1);
                      var booking = FilterBooking(
                          book_year: editedBooking.book_year,
                          book_month: editedBooking.book_month,
                          book_meridiem: editedBooking.book_meridiem,
                          book_court: '1',
                          book_active: editedBooking.book_active);
                      filterBooking(booking);
                    },
                    child: Text(
                      'Court A',
                      style: GoogleFonts.nunito(
                        color: ColorConstants.primaryColor,
                        fontSize: 18,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size.fromHeight(30),
                      side: BorderSide(
                        width: 3,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      setIsClick(2);
                      var booking = FilterBooking(
                          book_year: editedBooking.book_year,
                          book_month: editedBooking.book_month,
                          book_meridiem: editedBooking.book_meridiem,
                          book_court: '2',
                          book_active: editedBooking.book_active);
                      filterBooking(booking);
                    },
                    child: Text(
                      'Court B',
                      style: GoogleFonts.nunito(
                        color: ColorConstants.primaryColor,
                        fontSize: 18,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size.fromHeight(30),
                      side: BorderSide(
                        width: 3,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : isClick == 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          setIsClick(1);
                          var booking = FilterBooking(
                              book_year: editedBooking.book_year,
                              book_month: editedBooking.book_month,
                              book_meridiem: editedBooking.book_meridiem,
                              book_court: '1',
                              book_active: editedBooking.book_active);
                          filterBooking(booking);
                        },
                        child: Text(
                          'Court A',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.primaryColor,
                            fontSize: 18,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: ColorConstants.light_green,
                          minimumSize: Size.fromHeight(30),
                          side: BorderSide(
                            width: 3,
                            color: ColorConstants.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          setIsClick(2);
                          var booking = FilterBooking(
                              book_year: editedBooking.book_year,
                              book_month: editedBooking.book_month,
                              book_meridiem: editedBooking.book_meridiem,
                              book_court: '2',
                              book_active: editedBooking.book_active);
                          filterBooking(booking);
                        },
                        child: Text(
                          'Court B',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.primaryColor,
                            fontSize: 18,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size.fromHeight(30),
                          side: BorderSide(
                            width: 3,
                            color: ColorConstants.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          setIsClick(1);
                          var booking = FilterBooking(
                              book_year: editedBooking.book_year,
                              book_month: editedBooking.book_month,
                              book_meridiem: editedBooking.book_meridiem,
                              book_court: '1',
                              book_active: editedBooking.book_active);
                          filterBooking(booking);
                        },
                        child: Text(
                          'Court A',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.primaryColor,
                            fontSize: 18,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size.fromHeight(30),
                          side: BorderSide(
                            width: 3,
                            color: ColorConstants.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          setIsClick(2);
                          var booking = FilterBooking(
                              book_year: editedBooking.book_year,
                              book_month: editedBooking.book_month,
                              book_meridiem: editedBooking.book_meridiem,
                              book_court: '2',
                              book_active: editedBooking.book_active);
                          filterBooking(booking);
                        },
                        child: Text(
                          'Court B',
                          style: GoogleFonts.nunito(
                            color: ColorConstants.primaryColor,
                            fontSize: 18,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: ColorConstants.light_green,
                          minimumSize: Size.fromHeight(30),
                          side: BorderSide(
                            width: 3,
                            color: ColorConstants.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
  }
}
