import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/court.dart';
import '../models/booking.dart';

class Courts with ChangeNotifier {
  List<Court> _items = [];
  List<String> _courtTypeItems = [];

  List<Court> get items {
    return [..._items];
  }

  List<String> get courtTypeItems {
    return [..._courtTypeItems];
  }

  Future<void> readAllCourt() async {
    final authority = 'courtendahapiv1-dev.us-east-1.elasticbeanstalk.com';
    final path = '/api/court';
    final param = {'': ''};
    final url = Uri.http(authority, path);

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      final List<Court> loadedCourts = [];
      extractedData.forEach((courtData) {
        loadedCourts.add(Court(
          court_id: courtData['court_id'],
          court_type: courtData['court_type'],
          court_active: CourtActive.values[courtData['court_active']],
        ));
      });
      _items = loadedCourts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  String getCourtType(int id) {
    return _items.firstWhere((court) => court.court_id == id).court_type;
  }

  void readCourtType(List<Booking> bookings) {
    final List<Booking> loadedBookings = bookings;
    final List<String> loadedCourtTypes = [];
    for (var i = 0; i < loadedBookings.length; i++) {
      loadedCourtTypes.add(getCourtType(loadedBookings[i].court_id));
    }
    _courtTypeItems = loadedCourtTypes;
    notifyListeners();
  }
}
