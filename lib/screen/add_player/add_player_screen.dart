//Programmer Name : Mr Lim Ying Hao
//Program Name    : Endah Promenade Badminton Court Booking Application
//First Written on: 13-Feb-2023
//Edited on       : 1-May-2023

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/create_player.dart';
import '../../providers/players.dart';
import '../dashboard/dashboard_screen.dart';
import './my_dialog.dart';
import './background.dart';
import './username.dart';
import './cardno.dart';
import './fullname.dart';
import './password.dart';
import './signup.dart';
import './unitno.dart';
import './validatetext.dart';

class AddPlayerScreen extends StatefulWidget {
  static const routeName = '/add-player-screen';

  final Function getManagePlayers;

  AddPlayerScreen(this.getManagePlayers);

  @override
  State<AddPlayerScreen> createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  final _form = GlobalKey<FormState>();
  var isCheck = false;
  var checkCardNo = false;
  var _displayedText = '';

  var _editedPlayer = CreatePlayer(
      play_username: '',
      play_password: '',
      play_fullname: '',
      play_unitno: '',
      play_cardno: '',
      play_createdate: '',
      play_active: null);

  void _navigateScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void _createPlayer(CreatePlayer player) {
    _editedPlayer.play_username = player.play_username;
    _editedPlayer.play_password = player.play_password;
    _editedPlayer.play_fullname = player.play_fullname;
    _editedPlayer.play_unitno = player.play_unitno;
    _editedPlayer.play_cardno = player.play_cardno;
    _editedPlayer.play_createdate = player.play_createdate;
    _editedPlayer.play_active = player.play_active;
  }

  Future<void> _saveForm() async {
    isCheck = false;
    checkCardNo = false;
    final isValid = _form.currentState.validate();
    if (!isValid) {
      setState(() {
        _displayedText = '';
      });
      return;
    }

    _form.currentState.save();
    isCheck = Provider.of<Players>(context, listen: false)
        .checkUsername(_editedPlayer.play_username);
    checkCardNo = Provider.of<Players>(context, listen: false)
        .checkCardNo(_editedPlayer.play_cardno, null);
    setState(() {
      if (isCheck) {
        _displayedText = 'Username is already exists.';
        return;
      }
      if (checkCardNo) {
        _displayedText = 'Card number is already exists.';
        return;
      }
      _displayedText = '';
    });

    if (isCheck) {
      return;
    }
    if (checkCardNo) {
      return;
    }

    try {
      await Provider.of<Players>(context, listen: false)
          .createPlayer(_editedPlayer);
      await Provider.of<Players>(context, listen: false).readAllManagePlayer();
      await Provider.of<Players>(context, listen: false).readAllQueryPlayer();
      await showDialog(
        context: context,
        builder: (ctx) => MyDialog(
            'Create Account', 'The user account has been created successfully.',
            () {
          Navigator.pop(ctx);
        }),
      );
      await widget.getManagePlayers;
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => MyDialog(
          'An error occured!',
          'Something went wrong.',
          () => _navigateScreen(ctx, DashboardScreen.routeName),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Player',
        ),
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: [
            Background(),
            Username(_createPlayer, _editedPlayer),
            Password(_createPlayer, _editedPlayer),
            Fullname(_createPlayer, _editedPlayer),
            Unitno(_createPlayer, _editedPlayer),
            Cardno(_createPlayer, _editedPlayer),
            Validatetext(_displayedText),
            Signup(_saveForm),
          ],
        ),
      ),
    );
  }
}
