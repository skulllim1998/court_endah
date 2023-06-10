//Programmer Name : Mr Lim Ying Hao
//Program Name    : Endah Promenade Badminton Court Booking Application
//First Written on: 13-Feb-2023
//Edited on       : 1-May-2023

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/player.dart';
import './player_item.dart';
import '../../providers/players.dart';
import './viewmore.dart';
import '../../utils/custom_search_delegate.dart';
import 'add_player.dart';
import './my_dialog.dart';
import '../add_player/add_player_screen.dart';
import '../update_player/update_player_screen.dart';

class ManagePlayerScreen extends StatefulWidget {
  static const routeName = '/manage-player-screen';
  @override
  State<ManagePlayerScreen> createState() => _ManagePlayerScreenState();
}

class _ManagePlayerScreenState extends State<ManagePlayerScreen> {
  List<List<Player>> _managePlayers = [];
  List<String> _usernames = [];
  List<List<Player>> _filteredPlayers = [];
  var _index = 0;
  var _isFilter = false;
  var _player;

  void _navigateScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void _setIndex(int number) {
    setState(() {
      switch (number) {
        case 1:
          if (_index < (_managePlayers.length - 1)) {
            _index++;
            break;
          }
          break;
        case 2:
          if (_index > 0) {
            _index--;
            break;
          }
          break;
        case 3:
          if (_index < (_filteredPlayers.length - 1)) {
            _index++;
            break;
          }
          break;
        case 4:
          if (_index > 0) {
            _index--;
            break;
          }
          break;
      }
    });
  }

  void _getFilteredPlayers() {
    _filteredPlayers =
        Provider.of<Players>(context, listen: false).filteredItems;
    setState(() {
      _isFilter = true;
      _index = 0;
    });
  }

  void _getManagePlayers() {
    setState(() {
      _isFilter = false;
      _index = 0;
    });
  }

  void _deletePlayer(String username) {
    var player =
        Provider.of<Players>(context, listen: false).findByUsername(username);
    Provider.of<Players>(context, listen: false).deletePlayer(player.play_id);
  }

  @override
  Widget build(BuildContext context) {
    _managePlayers = Provider.of<Players>(context).manageItems;
    _usernames = Provider.of<Players>(context).queryItems;

    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: Text(
          'Manage Player',
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(_usernames),
                  );
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Future.delayed(Duration.zero, () async {
                    showDialog(
                      context: context,
                      builder: (ctx) => MyDialog(
                          'Delete',
                          'Are you sure you want to delete?',
                          _getFilteredPlayers,
                          _getManagePlayers),
                    );
                  });
                },
                child: Icon(
                  Icons.sort,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: _isFilter == false
          ? ListView(
              children: [
                ...(_managePlayers[_index]).map((player) {
                  return PlayerItem(player, _index);
                }).toList(),
              ],
            )
          : ListView(
              children: [
                ...(_filteredPlayers[_index]).map((player) {
                  return PlayerItem(player, _index);
                }).toList(),
              ],
            ),
      floatingActionButton:
          AddPlayer(() => _navigateScreen(context, AddPlayerScreen.routeName)),
      // floatingActionButton: AddPlayer(() {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => AddPlayerScreen(_getManagePlayers),
      //     ),
      //   );
      // }),
      bottomNavigationBar: Viewmore(_setIndex, _isFilter),
    );
  }
}
