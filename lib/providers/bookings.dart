import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/booking.dart';
import '../models/create_booking.dart';
import '../providers/player.dart';
import '../providers/players.dart';
import '../models/filter_booking.dart';
import '../models/update_booking.dart';

class Bookings with ChangeNotifier {
  List<Booking> _items = [];
  List<Booking> _myItems = [];
  List<Player> _playerItems = [];
  List<List<Booking>> _manageItems = [];
  List<String> _queryItems = [];
  List<List<Booking>> _filteredItems = [];

  List<Booking> get items {
    return [..._items];
  }

  List<Booking> get myItems {
    return [..._myItems];
  }

  List<List<Booking>> get manageItems {
    return [..._manageItems];
  }

  List<String> get queryItems {
    return [..._queryItems];
  }

  List<List<Booking>> get filteredItems {
    return [..._filteredItems];
  }

  //////////////////Read Methods//////////////////////

  Future<void> readAllBooking() async {
    final authority = 'courtendahapiv1-dev.us-east-1.elasticbeanstalk.com';
    final path = '/api/booking';
    final param = {'': ''};
    final url = Uri.http(authority, path);

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      final List<Booking> loadedBookings = [];
      extractedData.forEach((bookData) {
        loadedBookings.add(Booking(
          book_id: bookData['book_id'],
          book_date: bookData['book_date'],
          book_time: bookData['book_time'],
          court_id: bookData['court_id'],
          play_id: bookData['play_id'],
          book_createdate: bookData['book_createdate'],
          book_active: BookActive.values[bookData['book_active']],
        ));
      });
      _items = loadedBookings;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

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
      _playerItems = loadedPlayers;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void readMyBooking(int id) {
    final myBookings = _items
        .where((booking) =>
            booking.play_id == id && booking.book_active == BookActive.Active)
        .toList();
    _myItems = myBookings;
    print(_myItems.length);
    notifyListeners();
  }

  void readAllManageBooking() {
    var itemsLength = (_items.length / 5).round();
    final List<List<Booking>> loadedBookings =
        List.generate(itemsLength, (_) => []);
    var count = 0;
    var i = 0;

    _items.forEach((bookData) {
      loadedBookings[i].add(Booking(
        book_id: bookData.book_id,
        book_date: bookData.book_date,
        book_time: bookData.book_time,
        court_id: bookData.court_id,
        play_id: bookData.play_id,
        book_createdate: bookData.book_createdate,
        book_active: bookData.book_active,
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
    _manageItems = loadedBookings;
    notifyListeners();
  }

  void readAllQueryBooking() {
    final List<String> loadedUsernames = [];
    _playerItems.forEach((playData) {
      loadedUsernames.add(playData.play_username);
    });
    _queryItems = loadedUsernames;
    notifyListeners();
  }

  void readAllFilteredBooking(FilterBooking booking, int index) {
    var itemsLength = 1;

    var filteredBookings = getFilteredBookings(booking, index);
    if (filteredBookings.length >= 5) {
      itemsLength = (filteredBookings.length / 5).round();
    }
    final List<List<Booking>> loadedBookings =
        List.generate(itemsLength, (_) => []);
    var count = 0;
    var i = 0;
    filteredBookings.forEach((bookData) {
      loadedBookings[i].add(Booking(
          book_id: bookData.book_id,
          book_date: bookData.book_date,
          book_time: bookData.book_time,
          court_id: bookData.court_id,
          play_id: bookData.play_id,
          book_createdate: bookData.book_createdate,
          book_active: bookData.book_active));
    });
    count++;
    if (count == 5) {
      count = 0;
      i++;
      if (i >= itemsLength) {
        i--;
      }
    }
    _filteredItems = loadedBookings;
    print('filteritem:' + _filteredItems.length.toString());
    notifyListeners();
  }

  List<Booking> getFilteredBookings(FilterBooking booking, int index) {
    List<Booking> bookingItems = _items;

    switch (index) {
      case 1:
        if (booking.book_year != null &&
            booking.book_month == '' &&
            booking.book_meridiem == null) {
          bookingItems = filterByYear(booking);
          print(bookingItems.length);
          break;
        } else if (booking.book_month != null &&
            booking.book_year == '' &&
            booking.book_meridiem == null) {
          bookingItems = filterByMonth(booking);
          break;
        } else if (booking.book_meridiem != null &&
            booking.book_year == '' &&
            booking.book_month == '') {
          bookingItems = filterByMeridiem(booking);
          break;
        } else if (booking.book_year != null &&
            booking.book_month != null &&
            booking.book_meridiem == null) {
          bookingItems = filterByYearMonth(booking);
          break;
        } else if (booking.book_year != null &&
            booking.book_meridiem != null &&
            booking.book_month == '') {
          bookingItems = filterByYearMeridiem(booking);
          break;
        } else if (booking.book_month != null &&
            booking.book_meridiem != null &&
            booking.book_year == '') {
          bookingItems = filterByMonthMeridiem(booking);
          break;
        } else if (booking.book_year != null &&
            booking.book_month != null &&
            booking.book_meridiem != null) {
          bookingItems = filterByYearMonthMeridiem(booking);
          break;
        } else {
          bookingItems = _items;
        }
        break;
      case 2:
        if (booking.book_court != null && booking.book_active == null) {
          bookingItems = filterByCourt(booking);
          break;
        } else if (booking.book_active != null && booking.book_court == null) {
          bookingItems = filterByActive(booking);
          break;
        } else if (booking.book_active != null && booking.book_court != null) {
          bookingItems = filterByCourtActive(booking);
          break;
        } else {
          bookingItems = _items;
        }
        break;
    }
    return bookingItems;
  }

  List<Booking> filterByYear(FilterBooking booking) {
    return _items
        .where((bookData) =>
            bookData.book_date.substring(0, 4).toString() ==
            booking.book_year.toString())
        .toList();
  }

  List<Booking> filterByMonth(FilterBooking booking) {
    return _items
        .where((bookData) =>
            bookData.book_date.substring(5, 7) == booking.book_month.toString())
        .toList();
  }

  List<Booking> filterByMeridiem(FilterBooking booking) {
    return _items
        .where((bookData) => bookData.book_time.contains(booking.book_meridiem))
        .toList();
  }

  List<Booking> filterByYearMonth(FilterBooking booking) {
    return _items
        .where((bookData) =>
            bookData.book_date.substring(0, 4).toString() ==
                booking.book_year.toString() &&
            bookData.book_date.substring(5, 7) == booking.book_month.toString())
        .toList();
  }

  List<Booking> filterByYearMeridiem(FilterBooking booking) {
    return _items
        .where((bookData) =>
            bookData.book_date.substring(0, 4).toString() ==
                booking.book_year.toString() &&
            bookData.book_time.contains(booking.book_meridiem))
        .toList();
  }

  List<Booking> filterByMonthMeridiem(FilterBooking booking) {
    return _items
        .where((bookData) =>
            bookData.book_date.substring(5, 7) ==
                booking.book_month.toString() &&
            bookData.book_time.contains(booking.book_meridiem))
        .toList();
  }

  List<Booking> filterByYearMonthMeridiem(FilterBooking booking) {
    return _items
        .where((bookData) =>
            bookData.book_date.substring(0, 4).toString() ==
                booking.book_year.toString() &&
            bookData.book_date.substring(5, 7) ==
                booking.book_month.toString() &&
            bookData.book_time.contains(booking.book_meridiem))
        .toList();
  }

  List<Booking> filterByCourt(FilterBooking booking) {
    return _items
        .where((bookData) =>
            bookData.court_id.toString() == booking.book_court.toString())
        .toList();
  }

  List<Booking> filterByActive(FilterBooking booking) {
    return _items
        .where((bookData) =>
            bookData.book_active.index == int.parse(booking.book_active))
        .toList();
  }

  List<Booking> filterByCourtActive(FilterBooking booking) {
    return _items
        .where((bookData) =>
            bookData.court_id.toString() == booking.book_court.toString() &&
            bookData.book_active.index == int.parse(booking.book_active))
        .toList();
  }

  Booking findBookingById(int id) {
    return _items.firstWhere((booking) => booking.book_id == id);
  }

  Player findById(int id) =>
      _playerItems.firstWhere((player) => player.play_id == id);

  Player findByUsername(String username) =>
      _playerItems.firstWhere((player) => player.play_username == username);

  bool checkBookingByUnitNo(String date, int court, int myId) {
    var filteredBookings = filterByDate(date);
    var myPlayer = findById(myId);

    for (var i = 0; i < filteredBookings.length; i++) {
      var player = findById(filteredBookings[i].play_id);
      if (player.play_unitno == myPlayer.play_unitno) {
        return true;
      }
    }
    return false;
  }

  List<Booking> filterByDateCourt(String date, int court) {
    return _items
        .where(
            (booking) => booking.book_date == date && booking.court_id == court)
        .toList();
  }

  List<Booking> filterByDate(String date) {
    return _items.where((booking) => booking.book_date == date).toList();
  }

  List<Booking> filterByPlayId(int id) {
    return _items.where((booking) => booking.play_id == id).toList();
  }

  //////////////////Create Methods//////////////////////

  Future<bool> createBooking(CreateBooking booking) async {
    final authority = 'courtendahapiv1-dev.us-east-1.elasticbeanstalk.com';
    final path = '/api/booking';
    final param = {'': ''};
    final url = Uri.http(authority, path);

    var isCheck = checkBookingByUnitNo(
        booking.book_date, booking.court_id, booking.play_id);
    if (isCheck) {
      return false;
    }
    try {
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode({
          'book_date': booking.book_date,
          'book_time': booking.book_time,
          'court_id': booking.court_id,
          'play_id': booking.play_id,
          'book_createdate': booking.book_createdate,
          'book_active': booking.book_active.index,
        }),
      );

      final bookingId = json.decode(response.body)['book_id'];
      final newBooking = Booking(
          book_id: bookingId,
          book_date: booking.book_date,
          book_time: booking.book_time,
          court_id: booking.court_id,
          play_id: booking.play_id,
          book_createdate: booking.book_createdate,
          book_active: booking.book_active);
      _items.add(newBooking);
      notifyListeners();
      return true;
    } catch (error) {
      throw error;
    }
  }

  //////////////////Update Methods//////////////////////

  Future<bool> updateBooking(int id, UpdateBooking booking) async {
    final authority = 'courtendahapiv1-dev.us-east-1.elasticbeanstalk.com';
    final path = '/api/booking/update/' + id.toString();
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
          'book_date': booking.book_date,
          'book_time': booking.book_time,
          'court_id': booking.court_id,
        }),
      );

      var bookItem = _items.firstWhere((bookData) => bookData.book_id == id);
      bookItem.book_date = booking.book_date;
      bookItem.book_time = booking.book_time;
      bookItem.court_id = booking.court_id;
      notifyListeners();
      return true;
    } catch (error) {
      throw error;
    }
  }

  //////////////////Delete Methods//////////////////////

  Future<void> deleteBooking(int id, String role) async {
    final authority = 'courtendahapiv1-dev.us-east-1.elasticbeanstalk.com';
    final path = '/api/booking/' + id.toString();
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

      if (role == 'admin') {
        var bookItem = _items.firstWhere((bookData) => bookData.book_id == id);
        bookItem.book_active = BookActive.Inactive;
      } else if (role == 'player') {
        var bookItem = _items.firstWhere((bookData) => bookData.book_id == id);
        var myBookItem =
            _myItems.firstWhere((bookData) => bookData.book_id == id);
        bookItem.book_active = BookActive.Inactive;
        myBookItem.book_active = BookActive.Inactive;
      }
    } catch (error) {
      throw error;
    }
  }
}
