import 'package:flutter/material.dart';

import '../dashboard/dashboard_screen.dart';
import '../admin_profile.dart/admin_profile_screen.dart';

class AdminNavigation extends StatefulWidget {
  @override
  State<AdminNavigation> createState() => _AdminNavigationState();
}

class _AdminNavigationState extends State<AdminNavigation> {
  void _navigateScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed(DashboardScreen.routeName);
        break;

      case 1:
        Navigator.of(context).pushNamed(AdminProfileScreen.routeName);
        break;
    }
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
          _navigateScreen(context, _currentIndex);
        },
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home,
              size: 30.0,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.person,
              size: 30.0,
            ),
          ),
        ]);
  }
}
