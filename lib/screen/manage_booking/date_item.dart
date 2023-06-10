import 'package:flutter/material.dart';

import '../../models/filter_booking.dart';

class DateItem extends StatelessWidget {
  final Function filterBooking;
  final FilterBooking editedBooking;

  DateItem(this.filterBooking, this.editedBooking);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 100,
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Year',
                  hintText: 'Year'),
              onSaved: (newValue) {
                var booking = FilterBooking(
                    book_year: newValue,
                    book_month: editedBooking.book_month,
                    book_meridiem: editedBooking.book_meridiem,
                    book_court: editedBooking.book_court,
                    book_active: editedBooking.book_active);
                filterBooking(booking);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return null;
                }
                try {
                  int.parse(value);
                } catch (error) {
                  return 'Integer only.';
                }
                return null;
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 100,
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Month',
                  hintText: 'Month'),
              onSaved: (newValue) {
                var booking = FilterBooking(
                    book_year: editedBooking.book_year,
                    book_month: newValue,
                    book_meridiem: editedBooking.book_meridiem,
                    book_court: editedBooking.book_court,
                    book_active: editedBooking.book_active);
                filterBooking(booking);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return null;
                }
                try {
                  int.parse(value);
                } catch (error) {
                  return 'Integer only.';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
