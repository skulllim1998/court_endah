//Programmer Name : Mr Lim Ying Hao
//Program Name    : Endah Promenade Badminton Court Booking Application
//First Written on: 13-Feb-2023
//Edited on       : 1-May-2023

import 'package:court_endah/providers/courts.dart';
import 'package:court_endah/providers/login_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screen/welcome/welcome.dart';
import './screen/signup/signup_screen.dart';
import './screen/login/login_screen.dart';
import './utils/color_constants.dart';
import './screen/home/home_screen.dart';
import './providers/players.dart';
import './screen/booking/booking_screen.dart';
import './providers/bookings.dart';
import './screen/user_profile/profile_screen.dart';
import './screen/my_booking/mybooking_screen.dart';
import './screen/dashboard/dashboard_screen.dart';
import './providers/admins.dart';
import './screen/manage_player/manage_player_screen.dart';
import 'screen/add_player/add_player_screen.dart';
import './screen/admin_profile.dart/admin_profile_screen.dart';
import './screen/manage_booking/manage_booking_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Players(),
        ),
        ChangeNotifierProvider.value(
          value: Courts(),
        ),
        ChangeNotifierProvider.value(
          value: Bookings(),
        ),
        ChangeNotifierProvider.value(
          value: Admins(),
        ),
        ChangeNotifierProvider.value(
          value: LoginPref(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorConstants.backgroundColor,
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: ColorConstants.primaryColor,
              ),
        ),
        home: Welcome(),
        routes: {
          Welcome.routeName: (context) => Welcome(),
          SignupScreen.routeName: (context) => SignupScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          BookingScreen.routeName: (context) => BookingScreen(),
          ProfileScreen.routeName: (context) => ProfileScreen(),
          MybookingScreen.routeName: (context) => MybookingScreen(),
          DashboardScreen.routeName: (context) => DashboardScreen(),
          ManagePlayerScreen.routeName: (context) => ManagePlayerScreen(),
          AddPlayerScreen.routeName: (context) => AddPlayerScreen(null),
          AdminProfileScreen.routeName: (context) => AdminProfileScreen(),
          ManageBookingScreen.routeName: (context) => ManageBookingScreen(),
        },
      ),
    );
  }
}
