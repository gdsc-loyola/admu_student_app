import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_strings.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/models/user_cache.dart';
import 'package:admu_student_app/widgets/calendar/calendar.dart';
import 'package:admu_student_app/widgets/calendar/event_card_small.dart';
import 'package:admu_student_app/widgets/home/empty_state.dart';
import 'package:admu_student_app/widgets/modals/help.dart';
import 'package:admu_student_app/widgets/help_button.dart';

class CalendarTab extends StatefulWidget {
  final DateTime date;
  final Function(DateTime) onDateChange;

  CalendarTab({this.date, this.onDateChange});

  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  DateTime _date;

  @override
  void initState() {
    super.initState();

    if (widget.date != null)
      _date = widget.date;
    else
      _date = DateTime.now();

    /*if (UserCache.calendar) {
      UserCache.calendar = false;
      UserCache.save();

      WidgetsBinding.instance.addPostFrameCallback((_) => _showHowTo());
    }*/
  }

  void _showHowTo() async {
    await HelpModal.showHelp(
      context,
      title: 'Calendar',
      strings: [
        'Select a date to see your events and tasks for that day.',
        'Add some more by tapping the + button at the top right corner!',
      ],
    );
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
        Row(
          children: [
            Expanded(
              child: Text(
                _getDateString(),
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: AppColors.PRIMARY_ALT),
              ),
            ),
            SizedBox(width: 4),
            // HelpButton(onTap: _showHowTo),
          ],
        ),
        SizedBox(height: 8),
        _events.length > 0
            ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _events.length,
                itemBuilder: (_, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: SmallEventCard(
                      event: _events[index],
                      onMark: () => setState(() {}),
                    ),
                  );
                },
              )
            : EmptyState(
                topText: 'No Events Yet',
                bottomText:
                    'Create your events by tapping the + button at the top right corner!'),
      ],
    );
  }
}
