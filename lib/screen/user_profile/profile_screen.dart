//Programmer Name : Mr Lim Ying Hao
//Program Name    : Endah Promenade Badminton Court Booking Application
//First Written on: 13-Feb-2023
//Edited on       : 1-May-2023

import 'package:court_endah/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/login_pref.dart';
import '../welcome/welcome.dart';
import './heading.dart';
import './background.dart';
import './username.dart';
import './password.dart';
import './fullname.dart';
import './unitno.dart';
import './cardno.dart';
import './update.dart';
import './logout.dart';
import '../navigation/navigation.dart';
import '../../providers/player.dart';
import '../../providers/players.dart';
import '../../models/update_player.dart';
import './validatetext.dart';
import './my_dialog.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _form = GlobalKey<FormState>();
  String _username;
  Player _player;
  var _editedPlayer = UpdatePlayer(
      play_password: '',
      play_fullname: '',
      play_unitno: '',
      play_cardno: '',
      play_createdate: '',
      play_active: null);
  var checkCardNo = false;
  var _displayedText = '';

  Future<void> _logoutUser() async {
    Provider.of<LoginPref>(context, listen: false).logoutUser();
    _navigateScreen(context, Welcome.routeName);
  }

  void _navigateScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  Future<void> _getUsername() async {
    Provider.of<LoginPref>(context, listen: false)
        .getUsername()
        .then((username) => _username = username);
  }

  void _setUserProfile() {
    setState(() {
      _player = Provider.of<Players>(context, listen: false)
          .findByUsername(_username);
    });
  }

  void _updatePlayer(UpdatePlayer player) {
    _editedPlayer.play_password = player.play_password;
    _editedPlayer.play_fullname = player.play_fullname;
    _editedPlayer.play_unitno = player.play_unitno;
    _editedPlayer.play_cardno = player.play_cardno;
    _editedPlayer.play_createdate = _player.play_createdate;
    _editedPlayer.play_active = _player.play_active;
  }

  Future<void> _saveForm() async {
    checkCardNo = false;
    final isValid = _form.currentState.validate();
    if (!isValid) {
      setState(() {
        _displayedText = '';
      });
      return;
    }

    _form.currentState.save();
    checkCardNo = Provider.of<Players>(context, listen: false)
        .checkCardNo(_editedPlayer.play_cardno, _player);
    setState(() {
      if (checkCardNo) {
        _displayedText = 'Card number is already exists.';
        return;
      }
      _displayedText = '';
    });

    if (checkCardNo) {
      return;
    }

    try {
      await Provider.of<Players>(context, listen: false)
          .updatePlayer(_player.play_id, _editedPlayer);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Update Profile'),
          content: Text('Your profile is updated.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'),
            )
          ],
        ),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occured!'),
          content: Text('Something went wrong.'),
          actions: [
            TextButton(
              onPressed: () => _navigateScreen(ctx, HomeScreen.routeName),
              child: Text('Ok'),
            )
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getUsername().then((_) => _setUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _form,
          child: ListView(
            children: [
              Heading(),
              Background(),
              Username(_player.play_username),
              Password(_player.play_password, _updatePlayer, _editedPlayer),
              Fullname(_player.play_fullname, _updatePlayer, _editedPlayer),
              Unitno(_player.play_unitno, _updatePlayer, _editedPlayer),
              Cardno(_player.play_cardno, _updatePlayer, _editedPlayer),
              Validatetext(_displayedText),
              Update(_saveForm),
              Logout(() {
                showDialog(
                  context: context,
                  builder: (ctx) => MyDialog('Logout',
                      'Are you sure you want to logout?', _logoutUser),
                );
              }),
            ],
          )),
      bottomNavigationBar: Navigation(),
    );
  }
}
