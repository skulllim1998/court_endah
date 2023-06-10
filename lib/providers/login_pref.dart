import 'package:court_endah/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/login/login_screen.dart';
import '../screen/welcome/welcome.dart';

class LoginPref with ChangeNotifier {
  //SharedPreferences _pref;
  //BuildContext _context;
  var _isLogin = 'isLoggedin';
  var _keyUsername = 'username';

  // LoginPref(BuildContext context) {
  //   this._context = context;
  //   setIsLogin();
  // }

  // Future<void> setIsLogin() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool(_isLogin, false);
  // }

  // void _navigateScreen(BuildContext context, String routeName) {
  //   Navigator.of(context).pushNamed(routeName);
  // }

  // Future<SharedPreferences> getPref() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs;
  // }

  Future<void> createLoginSession(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isLogin, true);
    prefs.setString(_keyUsername, username);
  }

  // Future<void> checkLogin() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var isLogin = prefs.getBool(_isLogin);
  //   if (!isLogin) {
  //     _navigateScreen(_context, LoginScreen.routeName);
  //   }
  // }

  Future<String> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = '';
    username = prefs.getString(_keyUsername);
    return username;
  }

  Future<void> logoutUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool(_isLogin, false);
    // prefs.remove(_keyUsername);
    prefs.clear();
    //_navigateScreen(context, HomeScreen.routeName);
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLogin);
  }
}
