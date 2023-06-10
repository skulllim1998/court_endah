//Programmer Name : Mr Lim Ying Hao
//Program Name    : Endah Promenade Badminton Court Booking Application
//First Written on: 13-Feb-2023
//Edited on       : 1-May-2023

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/update_player.dart';
import '../../providers/player.dart';
import '../../providers/players.dart';
import '../dashboard/dashboard_screen.dart';
import './my_dialog.dart';
import './background.dart';
import './cardno.dart';
import './fullname.dart';
import './password.dart';
import './unitno.dart';
import './update.dart';
import './username.dart';
import './validatetext.dart';
import './active.dart';
import './delete.dart';
import './delete_dialog.dart';
import './active_status.dart';
import './create_date.dart';

class UpdatePlayerScreen extends StatefulWidget {
  static const routeName = '/update-player-screen';
  final String username;

  UpdatePlayerScreen(this.username);

  @override
  State<UpdatePlayerScreen> createState() => _UpdatePlayerScreenState();
}

class _UpdatePlayerScreenState extends State<UpdatePlayerScreen> {
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
  var _active = '';

  void _navigateScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
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

  void getActive() {
    switch (_player.play_active.index) {
      case 0:
        _active = 'Inactive';
        break;
      case 1:
        _active = 'Active';
        break;
    }
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
      await Provider.of<Players>(context, listen: false).readAllManagePlayer();
      await Provider.of<Players>(context, listen: false).readAllQueryPlayer();
      await showDialog(
        context: context,
        builder: (ctx) => MyDialog(
            'Update Account', 'The user account has been updated successfully.',
            () {
          Navigator.pop(ctx);
        }),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) =>
            MyDialog('An error occured!', 'Something went wrong.', () {
          _navigateScreen(ctx, DashboardScreen.routeName);
        }),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _username = widget.username;
    _player =
        Provider.of<Players>(context, listen: false).findByUsername(_username);
  }

  @override
  Widget build(BuildContext context) {
    getActive();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Player',
        ),
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: [
            Background(),
            Username(_username),
            Password(_player.play_password, _updatePlayer, _editedPlayer),
            Fullname(_player.play_fullname, _updatePlayer, _editedPlayer),
            Unitno(_player.play_unitno, _updatePlayer, _editedPlayer),
            Cardno(_player.play_cardno, _updatePlayer, _editedPlayer),
            CreateDate(_player.play_createdate),
            ActiveStatus(_active),
            Validatetext(_displayedText),
            Update(_saveForm),
            Active(_username),
            Delete(() {
              showDialog(
                context: context,
                builder: (ctx) => DeleteDialog('Delete Profile',
                    'Are you sure you want to delete?', _username),
              );
            }),
          ],
        ),
      ),
    );
  }
}
