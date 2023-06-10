//Programmer Name : Mr Lim Ying Hao
//Program Name    : Endah Promenade Badminton Court Booking Application
//First Written on: 13-Feb-2023
//Edited on       : 1-May-2023

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/booking.dart';
import '../../providers/bookings.dart';
import './background.dart';
import './booking_date.dart';
import './booking_time.dart';
import './court.dart';
import './username.dart';
import './create_date.dart';
import './active.dart';
import './delete.dart';
import '../../providers/player.dart';
import '../../providers/players.dart';
import './delete_dialog.dart';
import './my_dialog.dart';
import '../dashboard/dashboard_screen.dart';
import './update.dart';
import '../update_booking/update_booking_screen.dart';

class DeleteBookingScreen extends StatefulWidget {
  static const routeName = '/delete-booking-screen';
  final int bookId;

  DeleteBookingScreen(this.bookId);

  @override
  State<DeleteBookingScreen> createState() => _DeleteBookingScreenState();
}

class _DeleteBookingScreenState extends State<DeleteBookingScreen> {
  String _courtType;
  String _active;
  Player _player;
  Booking _booking;

  void _navigateScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void getCourtType() {
    switch (_booking.court_id) {
      case 1:
        _courtType = 'Court A';
        break;
      case 2:
        _courtType = 'Court B';
        break;
    }
  }

  void getActive() {
    switch (_booking.book_active.index) {
      case 0:
        _active = 'Inactive';
        break;
      case 1:
        _active = 'Active';
        break;
    }
  }

  Future<void> _deleteBooking(int id) async {
    try {
      await Provider.of<Bookings>(context, listen: false)
          .deleteBooking(id, 'admin');
      await Provider.of<Bookings>(context, listen: false)
          .readAllManageBooking();
      await Provider.of<Bookings>(context, listen: false).readAllQueryBooking();
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => MyDialog('An error occured!', error.toString(), () {
          _navigateScreen(ctx, DashboardScreen.routeName);
        }),
      );
    }
    await Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _booking = Provider.of<Bookings>(context, listen: false)
        .findBookingById(widget.bookId);
    _player =
        Provider.of<Players>(context, listen: false).findById(_booking.play_id);
  }

  @override
  Widget build(BuildContext context) {
    getCourtType();
    getActive();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cancel Booking',
        ),
      ),
      body: ListView(
        children: [
          Background(),
          BookingDate(_booking.book_date),
          BookingTime(_booking.book_time),
          Court(_courtType),
          Username(_player.play_username),
          CreateDate(DateTime.parse(_booking.book_createdate).year.toString() +
              '-' +
              DateTime.parse(_booking.book_createdate).month.toString() +
              '-' +
              DateTime.parse(_booking.book_createdate).day.toString()),
          Active(_active),
          Update(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateBookingScreen(_booking),
              ),
            );
          }),
          Delete(() {
            showDialog(
              context: context,
              builder: (ctx) => DeleteDialog(
                  'Cancel Booking',
                  'Are you sure you want to cancel?',
                  _deleteBooking,
                  _booking.book_id),
            );
          }),
        ],
      ),
    );
  }
}
