//Programmer Name : Mr Lim Ying Hao
//Program Name    : Endah Promenade Badminton Court Booking Application
//First Written on: 13-Feb-2023
//Edited on       : 1-May-2023

import 'package:court_endah/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './heading.dart';
import './sub_heading.dart';
import './background.dart';
import './signup.dart';
import './login.dart';
import '../signup/signup_screen.dart';
import '../login/login_screen.dart';
import '../../providers/players.dart';
import '../../providers/courts.dart';
import '../../providers/bookings.dart';
import '../../providers/login_pref.dart';
import '../../providers/admins.dart';
import '../dashboard/dashboard_screen.dart';

class Welcome extends StatefulWidget {
  static const routeName = '/welcome-screen';

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  var _isInit = true;
  var _isAllRead = false;
  String _username;

  void _navigateScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  Future<void> _getUsername() async {
    Provider.of<LoginPref>(context, listen: false)
        .getUsername()
        .then((username) => _username = username);
  }

  @override
  void initState() {
    _getUsername();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Players>(context).readAllPlayer();
      Provider.of<Courts>(context).readAllCourt();
      Provider.of<Bookings>(context).readAllBooking();
      Provider.of<Bookings>(context).readAllPlayer();
      Provider.of<Admins>(context).readAllAdmin().then((_) {
        setState(() {
          _isAllRead = true;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isAllRead == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _username == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Heading(),
                      Sub_Heading(),
                      Background(),
                      Signup(() =>
                          _navigateScreen(context, SignupScreen.routeName)),
                      Login(() =>
                          _navigateScreen(context, LoginScreen.routeName)),
                    ],
                  ),
                )
              : _username == 'admin'
                  ? DashboardScreen()
                  : HomeScreen(),
    );
  }
}
