import 'package:flutter/foundation.dart';

enum CourtActive {
  Inactive,
  Active,
}

class Court {
  final int court_id;
  final String court_type;
  final CourtActive court_active;

  const Court({
    @required this.court_id,
    @required this.court_type,
    @required this.court_active,
  });
}
