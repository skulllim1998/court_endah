//Programmer Name : Mr Lim Ying Hao
//Program Name    : Endah Promenade Badminton Court Booking Application
//First Written on: 13-Feb-2023
//Edited on       : 1-May-2023

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/login_pref.dart';
import '../welcome/welcome.dart';
import './background.dart';
import './logout.dart';
import './password.dart';
import './username.dart';
import './update.dart';
import '../../models/update_admin.dart';
import '../../models/admin.dart';
import '../../providers/admins.dart';
import '../dashboard/dashboard_screen.dart';
import './my_dialog.dart';
import '../navigation/admin_navigation.dart';

class AdminProfileScreen extends StatefulWidget {
  static const routeName = '/admin-profile-screen';

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  final _form = GlobalKey<FormState>();
  String _username;
  Admin _admin;
  var _editedAdmin = UpdateAdmin(admin_password: '');

  void _navigateScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  Future<void> _logoutUser() async {
    Provider.of<LoginPref>(context, listen: false).logoutUser();
    _navigateScreen(context, Welcome.routeName);
  }

  void _setAdminProfile() {
    setState(() {
      _admin = Provider.of<Admins>(context, listen: false).items[0];
    });
  }

  void _updateAdmin(UpdateAdmin admin) {
    _editedAdmin.admin_password = admin.admin_password;
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();

    try {
      await Provider.of<Admins>(context, listen: false)
          .updateAdmin(1, _editedAdmin);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Update Admin'),
          content: Text('Your password is updated.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'),
            )
          ],
        ),
      );
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
  }

  @override
  void initState() {
    super.initState();
    _setAdminProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Admin Profile',
          ),
        ),
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: [
            Background(),
            Username(_admin.admin_username),
            Password(_admin.admin_password, _updateAdmin, _editedAdmin),
            Update(_saveForm),
            Logout(() {
              showDialog(
                context: context,
                builder: (ctx) => MyDialog(
                    'Logout', 'Are you sure you want to logout?', _logoutUser),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: AdminNavigation(),
    );
  }
}
