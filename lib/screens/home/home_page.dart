import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/screens/home/pomodoro_page.dart';
import 'package:admu_student_app/widgets/home/event_card_preview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<Event> _events =
        Provider.of<CalendarEvents>(context, listen: false).events;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 48),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _events.length,
            itemBuilder: (_, index) => HomeEventCard(event: _events[index]),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PomodoroPage()),
              );
            },
            child: Text('Pomodoro'),
          ),
        ],
      ),
    );
  }
}
