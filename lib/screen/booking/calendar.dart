import 'package:court_endah/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/create_booking.dart';

class Calendar extends StatelessWidget {
  Map<DateTime, List<dynamic>> events;
  List<dynamic> selectedEvents;
  CalendarController controller;
  Function setSelectedEvents;
  final Function createBooking;
  CreateBooking editedBooking;
  final Function loadAvailableTime;

  Calendar(
      this.events,
      this.selectedEvents,
      this.controller,
      this.setSelectedEvents,
      this.createBooking,
      this.editedBooking,
      this.loadAvailableTime);

  String date2 = '';
  void display(DateTime date) {
    print(date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TableCalendar(
        events: events,
        initialCalendarFormat: CalendarFormat.week,
        availableGestures: AvailableGestures.none,
        headerStyle: HeaderStyle(
          centerHeaderTitle: true,
          headerPadding: EdgeInsets.all(20),
          formatButtonVisible: false,
          leftChevronVisible: false,
          rightChevronVisible: false,
        ),
        startingDayOfWeek: StartingDayOfWeek.monday,
        onDaySelected: (day, events, holidays) {
          setSelectedEvents(events);
        },
        builders: CalendarBuilders(
          dowWeekdayBuilder: (context, weekday) => Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                weekday,
              )),
          weekendDayBuilder: (context, date, events) => Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: null, borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                date.day.toString(),
                style: TextStyle(color: null),
              )),
          selectedDayBuilder: (context, date, events) {
            var month, day;
            if (date.month.toString().length < 2) {
              month = '0' + date.month.toString();
            } else {
              month = date.month.toString();
            }
            if (date.day.toString().length < 2) {
              day = '0' + date.day.toString();
            } else {
              day = date.day.toString();
            }

            var booking = CreateBooking(
                book_date: date.year.toString() + '-' + month + '-' + day,
                book_time: editedBooking.book_time,
                court_id: editedBooking.court_id,
                play_id: editedBooking.play_id,
                book_createdate: editedBooking.book_createdate,
                book_active: editedBooking.book_active);
            createBooking(booking);
            Future.delayed(Duration.zero, () async {
              loadAvailableTime();
            });

            return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
                ));
          },
          todayDayBuilder: (context, date, events) {
            return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                child: Text(
                  date.day.toString(),
                ));
          },
        ),
        calendarController: controller,
      ),
    );
  }
}
