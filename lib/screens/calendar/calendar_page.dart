import 'package:flutter/material.dart';

import 'package:admu_student_app/widgets/calendar/event_card.dart';
import 'package:admu_student_app/widgets/calendar/event_card_small.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<String> _labels = ['Hello World 0', '', 'Hello World 2'];
  List<String> _agendas = ['', 'Agenda 1', 'Agenda 2'];
  List<String> _tags = ['Tag 1', 'Tag 2', 'Tag 3'];
  List<DateTime> _starts = [
    DateTime.now(),
    DateTime.now().add(Duration(hours: 2)),
    null
  ];
  List<DateTime> _ends = [
    DateTime.now(),
    DateTime.now().add(Duration(hours: 5)),
    null
  ];

  @override
  Widget build(BuildContext context) {
    // get list from provider
    // listview builder from it

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
          ),
          Expanded(
            child: ListView.builder(
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
          ),
        ],
      ),
    );
  }
}
