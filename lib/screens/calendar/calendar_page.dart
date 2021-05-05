import 'package:flutter/material.dart';

import 'package:admu_student_app/widgets/calendar/event_card.dart';
import 'package:admu_student_app/widgets/calendar/event_card_small.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // data for testing, will move to provider
  List<String> _labels = [
    'Hello World 0',
    'Hello World 1',
    'Super long text super long text super long text',
    '',
    'Task 1',
    'Task 2',
  ];
  List<String> _agendas = [
    'Agenda 0',
    'Agenda 1',
    'Super long text super long text super long text',
    'Agenda 0',
    '',
    'Agenda 2',
  ];
  List<String> _tags = [
    'Tag 0',
    'Tag 1',
    'Super long text super long text super long text',
    'Tag 0',
    'Tag 1',
    ''
  ];
  List<DateTime> _starts = [
    DateTime.now(),
    DateTime.now().add(Duration(hours: 2)),
    DateTime.now().add(Duration(hours: 12)),
    DateTime.now(),
    null,
    DateTime.now(),
  ];
  List<DateTime> _ends = [
    DateTime.now(),
    DateTime.now().add(Duration(hours: 5)),
    DateTime.now().add(Duration(hours: 14)),
    DateTime.now(),
    DateTime.now(),
    null,
  ];

  @override
  Widget build(BuildContext context) {
    // get list from provider
    // listview builder from it

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _labels.length,
            itemBuilder: (_, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 8.0),
                child: SmallEventCard(
                  text: _labels[index],
                  start: _starts[index],
                ),
              );
            },
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _labels.length,
            itemBuilder: (_, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 8.0),
                child: EventCard(
                  text: _labels[index],
                  agenda: _agendas[index],
                  tags: _tags[index],
                  start: _starts[index],
                  end: _ends[index],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
