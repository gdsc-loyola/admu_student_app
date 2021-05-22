import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/widgets/calendar/calendar.dart';
import 'package:admu_student_app/widgets/calendar/event_card.dart';
import 'package:admu_student_app/widgets/calendar/event_card_small.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _date;

  @override
  void initState() {
    super.initState();

    _date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    List<Event> _events =
        Provider.of<CalendarEvents>(context).getEventsByDay(_date);

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0),
      child: Column(
        children: [
          CalendarMonth(
            date: _date,
            onDateChange: (DateTime date) {
              print('on date change');
              setState(() {
                _date = date;
              });
            },
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _events.length,
            itemBuilder: (_, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 8.0),
                child: SmallEventCard(event: _events[index]),
              );
            },
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _events.length,
            itemBuilder: (_, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 8.0),
                child: EventCard(event: _events[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
