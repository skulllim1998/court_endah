//Programmer Name : Mr Lim Ying Hao
//Program Name    : Endah Promenade Badminton Court Booking Application
//First Written on: 13-Feb-2023
//Edited on       : 1-May-2023

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'booking_item.dart';
import '../../providers/bookings.dart';
import '../../models/booking.dart';
import '../../providers/player.dart';
import '../../providers/login_pref.dart';
import '../../providers/players.dart';
import '../../providers/courts.dart';
import '../navigation/navigation.dart';

class MybookingScreen extends StatefulWidget {
  static const routeName = '/mybooking-screen';
  @override
  State<MybookingScreen> createState() => _MybookingScreenState();
}

class _MybookingScreenState extends State<MybookingScreen> {
  String _username;
  var _player = Player(
      play_id: null,
      play_username: '',
      play_password: '',
      play_fullname: '',
      play_unitno: '',
      play_cardno: '',
      play_createdate: '',
      play_active: null);
  List<Booking> _myBookings = [];
  List<String> _myCourtTypes = [];
  BookActive _bookActive;

  Future<void> _getUsername() async {
    Provider.of<LoginPref>(context, listen: false)
        .getUsername()
        .then((username) => _username = username);
  }

  void _deleteBooking(int index) {
    setState(() {
      var id = _myBookings[index].book_id;
      Provider.of<Bookings>(context, listen: false).deleteBooking(id, 'player');
      Provider.of<Bookings>(context, listen: false)
          .readMyBooking(_player.play_id);
      _myBookings = Provider.of<Bookings>(context, listen: false).myItems;
      Provider.of<Courts>(context, listen: false).readCourtType(_myBookings);
      _myCourtTypes =
          Provider.of<Courts>(context, listen: false).courtTypeItems;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUsername().then((_) {
      _player = Provider.of<Players>(context, listen: false)
          .findByUsername(_username);
      Provider.of<Bookings>(context, listen: false)
          .readMyBooking(_player.play_id);
      setState(() {
        _myBookings = Provider.of<Bookings>(context, listen: false).myItems;
        Provider.of<Courts>(context, listen: false).readCourtType(_myBookings);
        _myCourtTypes =
            Provider.of<Courts>(context, listen: false).courtTypeItems;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'My Bookings',
              textAlign: TextAlign.center,
            ),
          )),
      body: ListView.builder(
          itemCount: _myBookings.length,
          itemBuilder: (context, index) {
            return BookingItem(
                _myBookings, index, _myCourtTypes, _deleteBooking);
          }),
      bottomNavigationBar: Navigation(),
    );
  }
}
