import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/widgets/calendar/calendar.dart';
import 'package:admu_student_app/widgets/calendar/event_card_small.dart';

class MonthTab extends StatefulWidget {
  final DateTime date;
  final Function(DateTime) onDateChange;

  MonthTab({this.date, this.onDateChange});

  @override
  _MonthTabState createState() => _MonthTabState();
}

class _MonthTabState extends State<MonthTab> {
  DateTime _date;

  @override
  void initState() {
    super.initState();

    if (widget.date != null)
      _date = widget.date;
    else
      _date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    List<Event> _events =
        Provider.of<CalendarEvents>(context).getEventsByDay(_date);

    return Column(
      children: [
        CalendarMonth(
          date: _date,
          onDateChange: (DateTime date) {
            setState(() {
              _date = date;
            });

            if (widget.onDateChange != null) widget.onDateChange(_date);
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
      ],
    );
  }
}
