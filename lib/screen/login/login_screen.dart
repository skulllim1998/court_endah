//Programmer Name : Mr Lim Ying Hao
//Program Name    : Endah Promenade Badminton Court Booking Application
//First Written on: 13-Feb-2023
//Edited on       : 1-May-2023

import 'package:court_endah/screen/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './heading.dart';
import './background.dart';
import './username.dart';
import './password.dart';
import './login.dart';
import './signup.dart';
import '../home/home_screen.dart';
import '../signup/signup_screen.dart';
import './validatetext.dart';
import '../../providers/players.dart';
import '../../models/login_player.dart';
import '../../providers/login_pref.dart';
import '../../models/login_admin.dart';
import '../../providers/admins.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _editedPlayer = LoginPlayer(
    '',
    '',
  );
  var _editedAdmin = LoginAdmin(
    '',
    '',
  );
  var _displayedText = '';

  void _navigateScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void _loginPlayer(LoginPlayer player) {
    _editedPlayer.play_username = player.play_username;
    _editedPlayer.play_password = player.play_password;
  }

  void _loginAdmin() {
    _editedAdmin.admin_username = _editedPlayer.play_username;
    _editedAdmin.admin_password = _editedPlayer.play_password;
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      setState(() {
        _displayedText = '';
      });
      return;
    }

    _form.currentState.save();

    if (_editedPlayer.play_username == 'admin') {
      _loginAdmin();
      var adminSuccessful =
          Provider.of<Admins>(context, listen: false).loginAdmin(_editedAdmin);
      setState(() {
        if (adminSuccessful) {
          Provider.of<LoginPref>(context, listen: false)
              .createLoginSession('${_editedAdmin.admin_username}');

          _displayedText = '';
          _navigateScreen(context, DashboardScreen.routeName);
        } else {
          _displayedText = 'Incorrect username or password.';
        }
      });
      return;
    }

    var successful =
        Provider.of<Players>(context, listen: false).loginPlayer(_editedPlayer);
    var player = Provider.of<Players>(context, listen: false)
        .findByUsername(_editedPlayer.play_username);
    print('successful :' + successful.toString());
    setState(() {
      if (successful) {
        Provider.of<LoginPref>(context, listen: false)
            .createLoginSession('${_editedPlayer.play_username}');

        _displayedText = '';
        _navigateScreen(context, HomeScreen.routeName);
      } else if (player == null) {
        _displayedText = 'Incorrect username or password.';
      } else if (player.play_active.index == 0) {
        _displayedText = 'Your account is inactive.';
      } else if (!successful) {
        _displayedText = 'Incorrect username or password.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //_checkLogin();
    return Scaffold(
      body: Form(
        key: _form,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Heading(),
                Background(),
                Username(_loginPlayer, _editedPlayer),
                Password(_loginPlayer, _editedPlayer),
                Validatetext(_displayedText),
                Login(_saveForm),
                Signup(() => _navigateScreen(context, SignupScreen.routeName)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
