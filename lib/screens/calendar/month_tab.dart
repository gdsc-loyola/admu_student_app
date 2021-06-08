import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_strings.dart';
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

  String _getDateString() {
    DateTime now = DateTime.now();

    if (now.year == _date.year &&
        now.month == _date.month &&
        now.day == _date.day)
      return 'Today';
    else
      return '${AppStrings.DAYS[_date.weekday - 1]}, ${AppStrings.MONTHS[_date.month - 1]} ${_date.day}';
  }

  @override
  Widget build(BuildContext context) {
    List<Event> _events =
        Provider.of<CalendarEvents>(context).getEventsByDay(_date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 27),
        CalendarMonth(
          date: _date,
          onDateChange: (DateTime date) {
            setState(() {
              _date = date;
            });

            if (widget.onDateChange != null) widget.onDateChange(_date);
          },
        ),
        SizedBox(height: 16),
        Text(
          _getDateString(),
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: AppColors.PRIMARY_ALT),
        ),
        SizedBox(height: 8),
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
