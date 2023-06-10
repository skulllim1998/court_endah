import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/admin.dart';
import '../models/login_admin.dart';
import '../models/update_admin.dart';

class Admins with ChangeNotifier {
  List<Admin> _items = [];

  List<Admin> get items {
    return [..._items];
  }

  Admin findByUsername(String username) =>
      _items.firstWhere((admin) => admin.admin_username == username);

  Admin findById(int id) => _items.firstWhere((admin) => admin.admin_id == id);

  Future<void> readAllAdmin() async {
    final authority = 'courtendahapiv1-dev.us-east-1.elasticbeanstalk.com';
    final path = '/api/admin';
    final param = {'': ''};
    final url = Uri.http(authority, path);

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      final List<Admin> loadedAdmins = [];
      extractedData.forEach((adminData) {
        loadedAdmins.add(Admin(
          admin_id: adminData['admin_id'],
          admin_username: adminData['admin_username'],
          admin_password: adminData['admin_password'],
        ));
      });
      _items = loadedAdmins;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  bool loginAdmin(LoginAdmin admin) {
    for (var i = 0; i < _items.length; i++) {
      if (_items[i].admin_username == admin.admin_username &&
          _items[i].admin_password == admin.admin_password) {
        return true;
      }
    }
    return false;
  }

  Future<void> updateAdmin(int id, UpdateAdmin admin) async {
    final authority = 'courtendahapiv1-dev.us-east-1.elasticbeanstalk.com';
    final path = '/api/admin/' + id.toString();
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
          'admin_password': admin.admin_password,
        }),
      );
      var adminItem =
          _items.firstWhere((adminData) => adminData.admin_id == id);
      adminItem.admin_password = admin.admin_password;
    } catch (error) {
      throw error;
    }
  }
}
