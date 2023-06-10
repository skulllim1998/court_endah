//Programmer Name : Mr Lim Ying Hao
//Program Name    : Endah Promenade Badminton Court Booking Application
//First Written on: 13-Feb-2023
//Edited on       : 1-May-2023

import 'package:court_endah/screen/manage_player/manage_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './manage_item.dart';
import '../../utils/image_constants.dart';
import '../navigation/admin_navigation.dart';
import '../../providers/players.dart';
import '../manage_booking/manage_booking_screen.dart';
import '../../providers/bookings.dart';
import '../../providers/admins.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard-screen';
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var _isAllRead = false;

  void _navigateScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<Players>(context, listen: false).readAllPlayer().then((_) {
      Provider.of<Players>(context, listen: false).readAllManagePlayer();
      Provider.of<Players>(context, listen: false).readAllQueryPlayer();
    });

    Provider.of<Bookings>(context, listen: false).readAllBooking().then((_) {
      Provider.of<Bookings>(context, listen: false).readAllManageBooking();
      Provider.of<Bookings>(context, listen: false).readAllQueryBooking();
    });
    Provider.of<Admins>(context, listen: false).readAllAdmin().then((_) {
      setState(() {
        _isAllRead = true;
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
              'Dashboard',
              textAlign: TextAlign.center,
            ),
          )),
      body: _isAllRead == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView(
              padding: EdgeInsets.all(20),
              children: [
                ManageItem(
                    ImageConstants.manage_player,
                    'Manage Player',
                    () =>
                        _navigateScreen(context, ManagePlayerScreen.routeName)),
                ManageItem(
                    ImageConstants.manage_booking,
                    'Manage Booking',
                    () => _navigateScreen(
                        context, ManageBookingScreen.routeName)),
              ],
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: 2.0,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
              ),
            ),
      bottomNavigationBar: AdminNavigation(),
    );
  }
}
