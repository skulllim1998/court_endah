import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './block.dart';
import './level.dart';
import './date_item.dart';
import './active.dart';
import '../../models/filter_player.dart';
import '../../providers/players.dart';
import '../dashboard/dashboard_screen.dart';
import './filtermore.dart';

class MyDialog extends StatefulWidget {
  final String title;
  final String content;
  final Function getFilteredPlayers;
  final Function getManagePlayers;

  MyDialog(
      this.title, this.content, this.getFilteredPlayers, this.getManagePlayers);

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  var _isClick = 0;
  String _valueChoose = null;
  var _listItem = [
    'Active',
    'Inactive',
  ];
  final _form = GlobalKey<FormState>();
  var isCheck = false;
  var _editedPlayer = FilterPlayer(
      play_block: null,
      play_level: null,
      play_year: null,
      play_month: null,
      play_active: null);
  var _index = 1;

  void _navigateScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void _setIsClick(int block) {
    setState(() {
      switch (block) {
        case 1:
          _isClick = (_isClick * 0) + 1;
          break;
        case 2:
          _isClick = (_isClick * 0) + 2;
          break;
      }
    });
  }

  void _setValueChoose(String value) {
    setState(() {
      _valueChoose = value;
      if (_valueChoose == _listItem[0].toString()) {
        var player = FilterPlayer(
            play_block: _editedPlayer.play_block,
            play_level: _editedPlayer.play_level,
            play_year: _editedPlayer.play_year,
            play_month: _editedPlayer.play_month,
            play_active: '1');
        _filterPlayer(player);
      } else {
        var player = FilterPlayer(
            play_block: _editedPlayer.play_block,
            play_level: _editedPlayer.play_level,
            play_year: _editedPlayer.play_year,
            play_month: _editedPlayer.play_month,
            play_active: '0');
        _filterPlayer(player);
      }
    });
  }

  void _setIndex(int index) {
    setState(() {
      switch (index) {
        case 1:
          if (_index < 3) {
            _index++;
            break;
          }
          break;
        case 2:
          if (_index > 1) {
            _index--;
            break;
          }
          break;
      }
    });
  }

  void _filterPlayer(FilterPlayer player) {
    _editedPlayer.play_block = player.play_block;
    _editedPlayer.play_level = player.play_level;
    _editedPlayer.play_year = player.play_year;
    _editedPlayer.play_month = player.play_month;
    _editedPlayer.play_active = player.play_active;
  }

  Future<void> _saveForm() async {
    isCheck = false;
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    try {
      await Provider.of<Players>(context, listen: false)
          .readAllFilteredPlayer(_editedPlayer, _index);
      await widget.getFilteredPlayers();
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occured!'),
          content: Text('Something went wrong.'),
          actions: [
            TextButton(
              onPressed: () => _navigateScreen(ctx, DashboardScreen.routeName),
              child: Text('Ok'),
            )
          ],
        ),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: AlertDialog(
        title: Center(child: Text('Filters')),
        content: Container(
          height: 200,
          width: 300,
          child: Center(
            child: SingleChildScrollView(
              child: _index == 1
                  ? Column(
                      children: [
                        Block(_isClick, _setIsClick, _filterPlayer,
                            _editedPlayer),
                        Level(_filterPlayer, _editedPlayer),
                        Filtermore(_setIndex),
                      ],
                    )
                  : _index == 2
                      ? Column(
                          children: [
                            DateItem(_filterPlayer, _editedPlayer),
                            Filtermore(_setIndex),
                          ],
                        )
                      : Column(
                          children: [
                            Active(_valueChoose, _listItem, _setValueChoose),
                            Filtermore(_setIndex),
                          ],
                        ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _saveForm();
            },
            child: Text('Apply'),
          ),
          TextButton(
            onPressed: () {
              widget.getManagePlayers();
              Navigator.pop(context);
            },
            child: Text('Clear'),
          )
        ],
      ),
    );
  }
}
