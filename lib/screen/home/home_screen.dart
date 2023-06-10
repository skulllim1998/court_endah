//Programmer Name : Mr Lim Ying Hao
//Program Name    : Endah Promenade Badminton Court Booking Application
//First Written on: 13-Feb-2023
//Edited on       : 1-May-2023

import 'package:court_endah/providers/admins.dart';
import 'package:court_endah/screen/booking/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './stack_widget.dart';
import '../navigation/navigation.dart';
import '../../providers/players.dart';
import '../../providers/courts.dart';
import '../../providers/bookings.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isAllRead = false;

  @override
  void initState() {
    super.initState();
    Provider.of<Players>(context, listen: false).readAllPlayer();
    Provider.of<Courts>(context, listen: false).readAllCourt();
    Provider.of<Bookings>(context, listen: false).readAllBooking();
    Provider.of<Bookings>(context, listen: false).readAllPlayer();
    Provider.of<Admins>(context, listen: false).readAllAdmin().then((_) {
      setState(() {
        _isAllRead = true;
      });
    });
  }

  void _navigateScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isAllRead == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: StackWidget(
                  () => _navigateScreen(context, BookingScreen.routeName)),
            ),
      bottomNavigationBar: Navigation(),
    );
  }
}
