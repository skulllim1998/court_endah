import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/filter_booking.dart';
import '../dashboard/dashboard_screen.dart';
import './date_item.dart';
import './filtermore.dart';
import '../../providers/bookings.dart';
import './meridiem.dart';
import './active.dart';
import './court.dart';

class MyDialog extends StatefulWidget {
  final Function getFilteredBookings;
  final Function getManageBookings;

  MyDialog(this.getFilteredBookings, this.getManageBookings);

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  var _isClick = 0;
  String _valueChoose = null;
  var _listItem = [
    'Active',
    'Inactive',
  ];
  String _meridiemChoose = null;
  var _meridiemItems = [
    'AM',
    'PM',
  ];
  final _form = GlobalKey<FormState>();
  var isCheck = false;
  var _editedBooking = FilterBooking(
      book_year: null,
      book_month: null,
      book_meridiem: null,
      book_court: null,
      book_active: null);
  var _index = 1;

  void _navigateScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void _setIsClick(int block) {
    setState(() {
      switch (block) {
        case 1:
          _isClick = (_isClick * 0) + 1;
          break;
        case 2:
          _isClick = (_isClick * 0) + 2;
          break;
      }
    });
  }

  void _setValueChoose(String value) {
    setState(() {
      _valueChoose = value;
      if (_valueChoose == _listItem[0].toString()) {
        var booking = FilterBooking(
            book_year: _editedBooking.book_year,
            book_month: _editedBooking.book_month,
            book_meridiem: _editedBooking.book_meridiem,
            book_court: _editedBooking.book_court,
            book_active: '1');
        _filterBooking(booking);
      } else {
        var booking = FilterBooking(
            book_year: _editedBooking.book_year,
            book_month: _editedBooking.book_month,
            book_meridiem: _editedBooking.book_meridiem,
            book_court: _editedBooking.book_court,
            book_active: '0');
        _filterBooking(booking);
      }
    });
  }

  void _setMeridiemChoose(String value) {
    setState(() {
      _meridiemChoose = value;
      if (_meridiemChoose == _meridiemItems[0].toString()) {
        var booking = FilterBooking(
            book_year: _editedBooking.book_year,
            book_month: _editedBooking.book_month,
            book_meridiem: _meridiemChoose,
            book_court: _editedBooking.book_court,
            book_active: _editedBooking.book_active);
        _filterBooking(booking);
      } else {
        var booking = FilterBooking(
            book_year: _editedBooking.book_year,
            book_month: _editedBooking.book_month,
            book_meridiem: _meridiemChoose,
            book_court: _editedBooking.book_court,
            book_active: _editedBooking.book_active);
        _filterBooking(booking);
      }
    });
  }

  void _setIndex(int index) {
    setState(() {
      switch (index) {
        case 1:
          if (_index < 2) {
            _index++;
            break;
          }
          break;
        case 2:
          if (_index > 1) {
            _index--;
            break;
          }
          break;
      }
    });
  }

  void _filterBooking(FilterBooking booking) {
    _editedBooking.book_year = booking.book_year;
    _editedBooking.book_month = booking.book_month;
    _editedBooking.book_meridiem = booking.book_meridiem;
    _editedBooking.book_court = booking.book_court;
    _editedBooking.book_active = booking.book_active;
  }

  Future<void> _saveForm() async {
    isCheck = false;
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    try {
      await Provider.of<Bookings>(context, listen: false)
          .readAllFilteredBooking(_editedBooking, _index);
      await widget.getFilteredBookings();
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
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: AlertDialog(
        title: Center(child: Text('Filters')),
        content: Container(
          height: 200,
          width: 300,
          child: Center(
            child: SingleChildScrollView(
              child: _index == 1
                  ? Column(
                      children: [
                        DateItem(_filterBooking, _editedBooking),
                        Meridiem(_meridiemChoose, _meridiemItems,
                            _setMeridiemChoose),
                        Filtermore(_setIndex),
                      ],
                    )
                  : Column(
                      children: [
                        Court(_isClick, _setIsClick, _filterBooking,
                            _editedBooking),
                        Active(_valueChoose, _listItem, _setValueChoose),
                        Filtermore(_setIndex),
                      ],
                    ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _saveForm();
            },
            child: Text('Apply'),
          ),
          TextButton(
            onPressed: () {
              widget.getManageBookings();
              Navigator.pop(context);
            },
            child: Text('Clear'),
          )
        ],
      ),
    );
  }
}
