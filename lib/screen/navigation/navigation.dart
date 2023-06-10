import 'package:court_endah/screen/my_booking/mybooking_screen.dart';
import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../user_profile/profile_screen.dart';

class Navigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  void _navigateScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed(HomeScreen.routeName);
        break;

      case 1:
        Navigator.of(context).pushNamed(MybookingScreen.routeName);
        break;

      case 2:
        Navigator.of(context).pushNamed(ProfileScreen.routeName);
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
            _navigateScreen(context, _currentIndex);
          });
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
              Icons.menu,
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
