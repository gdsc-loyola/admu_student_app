import 'package:flutter/material.dart';

import 'package:admu_student_app/screens/calendar/month_tab.dart';

class CalendarPage extends StatefulWidget {
  final DateTime date;
  final Function(DateTime) onDateChange;

  CalendarPage({this.date, this.onDateChange});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _date;

  @override
  void initState() {
    super.initState();

    if (widget.date != null)
      _date = widget.date;
    else
      _date = DateTime.now();
  }

  void _onDateChange(DateTime date) {
    setState(() {
      _date = date;
    });

    if (widget.onDateChange != null) widget.onDateChange(date);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: Column(
        children: [
          MonthTab(date: _date, onDateChange: _onDateChange),
        ],
      ),
    );
  }
}
