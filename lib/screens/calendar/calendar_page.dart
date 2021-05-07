import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/widgets/calendar/event_card.dart';
import 'package:admu_student_app/widgets/calendar/event_card_small.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    List<Event> _events =
        Provider.of<CalendarEvents>(context, listen: false).events;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
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
