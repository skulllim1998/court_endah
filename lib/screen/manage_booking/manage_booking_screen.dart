//Programmer Name : Mr Lim Ying Hao
//Program Name    : Endah Promenade Badminton Court Booking Application
//First Written on: 13-Feb-2023
//Edited on       : 1-May-2023

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/bookings.dart';
import '../../models/booking.dart';
import './booking_item.dart';
import './viewmore.dart';
import './my_dialog.dart';
import '../../utils/custom_search_delegate.dart';

class ManageBookingScreen extends StatefulWidget {
  static const routeName = '/manage-booking-screen';

  @override
  State<ManageBookingScreen> createState() => _ManageBookingScreenState();
}

class _ManageBookingScreenState extends State<ManageBookingScreen> {
  List<List<Booking>> _manageBookings = [];
  List<String> _usernames = [];
  List<List<Booking>> _filteredBookings = [];
  var _index = 0;
  var _isFilter = false;
  var _booking;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _manageBookings = Provider.of<Bookings>(context, listen: false).manageItems;
    _usernames = Provider.of<Bookings>(context, listen: false).queryItems;
  }

  void _navigateScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void _setIndex(int number) {
    setState(() {
      switch (number) {
        case 1:
          if (_index < (_manageBookings.length - 1)) {
            _index++;
            break;
          }
          break;
        case 2:
          if (_index > 0) {
            _index--;
            break;
          }
          break;
        case 3:
          if (_index < (_filteredBookings.length - 1)) {
            _index++;
            break;
          }
          break;
        case 4:
          if (_index > 0) {
            _index--;
            break;
          }
          break;
      }
    });
  }

  void _getFilteredBookings() {
    _filteredBookings =
        Provider.of<Bookings>(context, listen: false).filteredItems;
    setState(() {
      _isFilter = true;
      _index = 0;
    });
  }

  void _getManageBookings() {
    setState(() {
      _isFilter = false;
      _index = 0;
    });
  }

  // void _deleteBooking(String username) {
  //   var player =
  //       Provider.of<Players>(context, listen: false).findByUsername(username);
  //   Provider.of<Players>(context, listen: false).deletePlayer(player.play_id);
  // }

  @override
  Widget build(BuildContext context) {
    _manageBookings = Provider.of<Bookings>(context).manageItems;
    _usernames = Provider.of<Bookings>(context).queryItems;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Booking',
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Future.delayed(Duration.zero, () async {
                    showDialog(
                      context: context,
                      builder: (ctx) =>
                          MyDialog(_getFilteredBookings, _getManageBookings),
                    );
                  });
                },
                child: Icon(
                  Icons.sort,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: _isFilter == false
          ? ListView(
              children: [
                ...(_manageBookings[_index]).map((booking) {
                  return BookingItem(booking, _index);
                }).toList(),
              ],
            )
          : ListView(
              children: [
                ...(_filteredBookings[_index]).map((booking) {
                  return BookingItem(booking, _index);
                }).toList(),
              ],
            ),
      //floatingActionButton:
      //AddPlayer(() => _navigateScreen(context, AddPlayerScreen.routeName)),
      bottomNavigationBar: Viewmore(_setIndex, _isFilter),
    );
  }
}
