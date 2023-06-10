import 'package:flutter/foundation.dart';

class Admin {
  final int admin_id;
  final String admin_username;
  String admin_password;

  Admin({
    @required this.admin_id,
    @required this.admin_username,
    @required this.admin_password,
  });
}
