import 'package:flutter/material.dart';

import 'package:admu_student_app/screens/calendar/add_event.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => AddEventPage()),
            );
          },
          child: Text('add new event'),
        ),
      ],
    );
  }
}
