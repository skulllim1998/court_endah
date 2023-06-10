//Programmer Name : Mr Lim Ying Hao
//Program Name    : Endah Promenade Badminton Court Booking Application
//First Written on: 13-Feb-2023
//Edited on       : 1-May-2023

import 'package:court_endah/screen/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../data/available_time.dart';
import '../../providers/player.dart';
import '../../models/update_booking.dart';
import '../../providers/bookings.dart';
import './calendar.dart';
import './court.dart';
import './time.dart';
import './update.dart';
import '../../models/booking.dart';

class UpdateBookingScreen extends StatefulWidget {
  static const routeName = '/update-booking-screen';
  final Booking booking;

  UpdateBookingScreen(this.booking);

  @override
  State<UpdateBookingScreen> createState() => _UpdateBookingScreenState();
}

class _UpdateBookingScreenState extends State<UpdateBookingScreen> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;
  int _isClick = 1;
  String _timeClick = '';
  List<String> _availableTime;
  var _editedBooking =
      UpdateBooking(book_date: '', book_time: '', court_id: 1, play_id: null);
  var _isValid = false;
  String _username = '';
  Player _player;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    _availableTime = availableTime.toList();
    Future.delayed(Duration.zero, () async {
      _loadAvailableTime();
    });
    prefsData();
    _editedBooking.play_id = widget.booking.play_id;
  }

  prefsData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  void _setSelectedEvents(List<dynamic> events) {
    setState(() {
      _selectedEvents = events;
    });
  }

  void _addEvent() {
    setState(() {
      if (_events[_controller.selectedDay] != null) {
        _events[_controller.selectedDay].add(_eventController.text);
      } else {
        _events[_controller.selectedDay] = [_eventController.text];
      }
      prefs.setString("events", json.encode(encodeMap(_events)));
      _eventController.clear();
      Navigator.pop(context);
    });
  }

  void _setIsClick(int court) {
    setState(() {
      switch (court) {
        case 1:
          _isClick = (_isClick * 0) + 1;
          break;
        case 2:
          _isClick = (_isClick * 0) + 2;
          break;
      }
    });

    var booking = UpdateBooking(
        book_date: _editedBooking.book_date,
        book_time: _editedBooking.book_time,
        court_id: court,
        play_id: widget.booking.play_id);
    _updateBooking(booking);
    Future.delayed(Duration.zero, () async {
      _loadAvailableTime();
    });
  }

  void _setTimeClick(String time) {
    setState(() {
      _timeClick = time;
    });
  }

  void _setIsValid(bool isValid) {
    _isValid = isValid;
  }

  void _navigateScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void _updateBooking(UpdateBooking booking) {
    _editedBooking.book_date = booking.book_date;
    _editedBooking.book_time = booking.book_time;
    _editedBooking.court_id = booking.court_id;
    _editedBooking.play_id = booking.play_id;
  }

  void _loadAvailableTime() {
    _availableTime = availableTime.toList();
    var bookedTime = Provider.of<Bookings>(context, listen: false)
        .filterByDateCourt(_editedBooking.book_date, _editedBooking.court_id)
        .toList();

    setState(() {
      for (var i = 0; i < bookedTime.length; i++) {
        _availableTime.removeWhere((time) => time == bookedTime[i].book_time);
      }
    });
  }

  Future<void> _saveBooking() async {
    if (!_isValid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Text('Please select a time.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'),
            )
          ],
        ),
      );
      return;
    }

    try {
      var isCheck = false;
      await Provider.of<Bookings>(context, listen: false)
          .updateBooking(widget.booking.book_id, _editedBooking)
          .then((success) => isCheck = success);
      if (!isCheck) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Duplicate Booking'),
            content: Text('A unit can only book once per day.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Ok'),
              )
            ],
          ),
        );
        return;
      }
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Confirm Update'),
          content: Text('The booking is updated.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'),
            )
          ],
        ),
      );
      await Provider.of<Bookings>(context, listen: false)
          .readAllManageBooking();
      await Provider.of<Bookings>(context, listen: false).readAllQueryBooking();
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occured!'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => _navigateScreen(ctx, DashboardScreen.routeName),
              child: Text('Ok'),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Update Booking',
        textAlign: TextAlign.center,
      )),
      body: Column(
        children: [
          Calendar(
              _events,
              _selectedEvents,
              _controller,
              _setSelectedEvents,
              _updateBooking,
              _editedBooking,
              _loadAvailableTime,
              widget.booking.book_date),
          Court(_isClick, _setIsClick),
          Expanded(
            child: GridView(
              padding: EdgeInsets.all(20),
              children: _availableTime
                  .map((timeData) => Time(timeData, _updateBooking,
                      _editedBooking, _setTimeClick, _timeClick, _setIsValid))
                  .toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 120,
                childAspectRatio: 1.7,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
            ),
          ),
          Update(_saveBooking),
          //ConfirmBooking(_saveBooking, _createBooking, _editedBooking),
        ],
      ),
    );
  }
}
