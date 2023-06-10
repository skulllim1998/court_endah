import 'dart:convert';
import 'package:court_endah/models/filter_player.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/create_player.dart';
import './player.dart';
import '../models/login_player.dart';
import '../models/update_player.dart';

class Players with ChangeNotifier {
  List<Player> _items = [];
  List<List<Player>> _manageItems = [];
  List<String> _queryItems = [];
  List<List<Player>> _filteredItems = [];

  List<Player> get items {
    return [..._items];
  }

  List<List<Player>> get manageItems {
    return [..._manageItems];
  }

  List<String> get queryItems {
    return [..._queryItems];
  }

  List<List<Player>> get filteredItems {
    return [..._filteredItems];
  }

  //////////////////Read Methods//////////////////////

  Future<void> readAllPlayer() async {
    final authority = 'courtendahapiv1-dev.us-east-1.elasticbeanstalk.com';
    final path = '/api/player';
    final param = {'': ''};
    final url = Uri.http(authority, path);

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      final List<Player> loadedPlayers = [];
      extractedData.forEach((playData) {
        loadedPlayers.add(Player(
          play_id: playData['play_id'],
          play_username: playData['play_username'],
          play_password: playData['play_password'],
          play_fullname: playData['play_fullname'],
          play_unitno: playData['play_unitno'],
          play_cardno: playData['play_cardno'],
          play_createdate: playData['play_createdate'],
          play_active: PlayActive.values[playData['play_active']],
        ));
      });
      _items = loadedPlayers;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void readAllManagePlayer() {
    var itemsLength = (_items.length / 5).round();
    final List<List<Player>> loadedPlayers =
        List.generate(itemsLength, (_) => []);
    var count = 0;
    var i = 0;
    _items.forEach((playData) {
      loadedPlayers[i].add(Player(
        play_id: playData.play_id,
        play_username: playData.play_username,
        play_password: playData.play_password,
        play_fullname: playData.play_fullname,
        play_unitno: playData.play_unitno,
        play_cardno: playData.play_cardno,
        play_createdate: playData.play_createdate,
        play_active: playData.play_active,
      ));
      count++;
      if (count == 5) {
        count = 0;
        i++;
        if (i >= itemsLength) {
          i--;
        }
      }
    });
    _manageItems = loadedPlayers;
    notifyListeners();
  }

  void readAllQueryPlayer() {
    final List<String> loadedUsernames = [];
    _items.forEach((playData) {
      loadedUsernames.add(playData.play_username);
    });
    _queryItems = loadedUsernames;
    notifyListeners();
  }

  void readAllFilteredPlayer(FilterPlayer player, int index) {
    var itemsLength = 1;

    var filteredPlayers = getFilteredPlayers(player, index);
    if (filteredPlayers.length >= 5) {
      itemsLength = (filteredPlayers.length / 5).round();
    }
    final List<List<Player>> loadedPlayers =
        List.generate(itemsLength, (_) => []);
    var count = 0;
    var i = 0;
    filteredPlayers.forEach((playData) {
      loadedPlayers[i].add(Player(
        play_id: playData.play_id,
        play_username: playData.play_username,
        play_password: playData.play_password,
        play_fullname: playData.play_fullname,
        play_unitno: playData.play_unitno,
        play_cardno: playData.play_cardno,
        play_createdate: playData.play_createdate,
        play_active: playData.play_active,
      ));
      count++;
      if (count == 5) {
        count = 0;
        i++;
        if (i >= itemsLength) {
          i--;
        }
      }
    });
    _filteredItems = loadedPlayers;
    notifyListeners();
  }

  List<Player> getFilteredPlayers(FilterPlayer player, int index) {
    List<Player> playerItems = _items;

    switch (index) {
      case 1:
        if (player.play_block != null && player.play_level == '') {
          playerItems = filterByBlock(player);
          break;
        } else if (player.play_level != null && player.play_block == null) {
          playerItems = filterByLevel(player);
          break;
        } else if (player.play_block != null && player.play_level != null) {
          playerItems = filterByBlockLevel(player);
          break;
        } else {
          playerItems = _items;
          break;
        }
        break;
      case 2:
        if (player.play_year != null && player.play_month == '') {
          playerItems = filterByYear(player);
          break;
        } else if (player.play_month != null && player.play_year == '') {
          playerItems = filterByMonth(player);
          break;
        } else if (player.play_year != null && player.play_month != null) {
          playerItems = filterByYearMonth(player);
          break;
        }
        break;
      case 3:
        if (player.play_active != null) {
          playerItems = filterByActive(player);
          break;
        }
        break;
    }
    return playerItems;
  }

  Player findByUsername(String username) {
    try {
      return _items.firstWhere((player) => player.play_username == username);
    } catch (error) {
      return null;
    }
  }

  Player findById(int id) =>
      _items.firstWhere((player) => player.play_id == id);

  List<Player> filterByBlock(FilterPlayer player) {
    return _items
        .where((playData) =>
            playData.play_unitno[0].toString().toLowerCase() ==
            player.play_block.toString().toLowerCase())
        .toList();
  }

  List<Player> filterByLevel(FilterPlayer player) {
    var filterPlayer = player;
    return _items
        .where((playData) =>
            playData.play_unitno[1].toString() ==
                filterPlayer.play_level[0].toString() &&
            playData.play_unitno[2].toString() ==
                filterPlayer.play_level[1].toString())
        .toList();
  }

  List<Player> filterByBlockLevel(FilterPlayer player) {
    return _items
        .where((playData) =>
            playData.play_unitno[0].toString().toLowerCase() ==
                player.play_block.toString().toLowerCase() &&
            playData.play_unitno.substring(1, 3).toString() ==
                player.play_level.toString())
        .toList();
  }

  List<Player> filterByYear(FilterPlayer player) {
    return _items
        .where((playData) =>
            DateTime.parse(playData.play_createdate).year.toString() ==
            player.play_year.toString())
        .toList();
  }

  List<Player> filterByMonth(FilterPlayer player) {
    return _items
        .where((playData) =>
            DateTime.parse(playData.play_createdate).month.toString() ==
            int.parse(player.play_month).toString())
        .toList();
  }

  List<Player> filterByYearMonth(FilterPlayer player) {
    return _items
        .where((playData) =>
            DateTime.parse(playData.play_createdate).year.toString() ==
                player.play_year.toString() &&
            DateTime.parse(playData.play_createdate).month.toString() ==
                int.parse(player.play_month).toString())
        .toList();
  }

  List<Player> filterByActive(FilterPlayer player) {
    return _items
        .where((playData) =>
            playData.play_active.index == int.parse(player.play_active))
        .toList();
  }

  bool loginPlayer(LoginPlayer player) {
    for (var i = 0; i < _items.length; i++) {
      if (_items[i].play_username == player.play_username &&
          _items[i].play_password == player.play_password &&
          _items[i].play_active.index == 1) {
        return true;
      }
    }
    return false;
  }

  bool checkUsername(String username) {
    for (var i = 0; i < _items.length; i++) {
      if (_items[i].play_username == username) {
        return true;
      }
    }
    return false;
  }

  bool checkCardNo(String cardNo, Player player) {
    if (player != null && player.play_cardno == cardNo) {
      return false;
    }
    for (var i = 0; i < _items.length; i++) {
      if (_items[i].play_cardno == cardNo) {
        return true;
      }
    }
    return false;
  }

  //////////////////Create Methods//////////////////////

  Future<void> createPlayer(CreatePlayer player) async {
    final authority = 'courtendahapiv1-dev.us-east-1.elasticbeanstalk.com';
    final path = '/api/player';
    final param = {'': ''};
    final url = Uri.http(authority, path);
    try {
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode({
          'play_username': player.play_username,
          'play_password': player.play_password,
          'play_fullname': player.play_fullname,
          'play_unitno': player.play_unitno,
          'play_cardno': player.play_cardno,
          'play_createdate': player.play_createdate,
          'play_active': player.play_active.index,
        }),
      );

      final playerId = json.decode(response.body)['play_id'];
      final newPlayer = Player(
          play_id: playerId,
          play_username: player.play_username,
          play_password: player.play_password,
          play_fullname: player.play_fullname,
          play_unitno: player.play_unitno,
          play_cardno: player.play_cardno,
          play_createdate: player.play_createdate,
          play_active: player.play_active);
      _items.add(newPlayer);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  //////////////////Update Methods//////////////////////

  Future<void> updatePlayer(int id, UpdatePlayer player) async {
    final authority = 'courtendahapiv1-dev.us-east-1.elasticbeanstalk.com';
    final path = '/api/player/' + id.toString();
    final param = {'': ''};
    final url = Uri.http(authority, path);

    try {
      http.put(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode({
          'play_password': player.play_password,
          'play_fullname': player.play_fullname,
          'play_unitno': player.play_unitno,
          'play_cardno': player.play_cardno,
          'play_createdate': player.play_createdate,
          'play_active': player.play_active.index,
        }),
      );

      var playItem = _items.firstWhere((playData) => playData.play_id == id);
      playItem.play_password = player.play_password;
      playItem.play_fullname = player.play_fullname;
      playItem.play_unitno = player.play_unitno;
      playItem.play_cardno = player.play_cardno;
      playItem.play_createdate = player.play_createdate;
      playItem.play_active = player.play_active;
    } catch (error) {
      throw error;
    }
  }

  //////////////////Delete Methods//////////////////////
  Future<void> deletePlayer(int id) async {
    final authority = 'courtendahapiv1-dev.us-east-1.elasticbeanstalk.com';
    final path = '/api/player/delete/' + id.toString();
    final param = {'': ''};
    final url = Uri.http(authority, path);

    try {
      http.put(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );

      var playItem = _items.firstWhere((playData) => playData.play_id == id);
      playItem.play_active = PlayActive.Inactive;
    } catch (error) {
      throw error;
    }
  }

  Future<void> activePlayer(int id) async {
    final authority = 'courtendahapiv1-dev.us-east-1.elasticbeanstalk.com';
    final path = '/api/player/active/' + id.toString();
    final param = {'': ''};
    final url = Uri.http(authority, path);

    try {
      http.put(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );

      var playItem = _items.firstWhere((playData) => playData.play_id == id);
      playItem.play_active = PlayActive.Active;
    } catch (error) {
      throw error;
    }
  }
}
