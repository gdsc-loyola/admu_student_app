import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';

class CalendarMonth extends StatelessWidget {
  final List<String> _MONTHS = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  final List<String> _DAYS = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];

  final DateTime date;

  final VoidCallback onPressedLeft;
  final VoidCallback onPressedRight;
  final Function(DateTime) onPressedDay;

  CalendarMonth({
    @required this.date,
    @required this.onPressedLeft,
    @required this.onPressedRight,
    @required this.onPressedDay,
  });

  Widget _buildDays(BuildContext context) {
    List<Widget> children = [];

    for (int i = 0; i < _DAYS.length; i++)
      children.add(
        Expanded(
          child: Center(
            child: Text(
              _DAYS[i],
              style: Theme.of(context).textTheme.caption.copyWith(
                  fontWeight: FontWeight.w500, color: Color(0x4D3C3C43)),
            ),
          ),
        ),
      );

    return Row(children: children);
  }

  Widget _buildDates(BuildContext context, List<Event> events) {
    List<Widget> mainChildren = [];

    DateTime tDate = DateTime(date.year, date.month);

    // build per row

    List<Widget> allDays = [];

    if (tDate.weekday != DateTime.sunday) {
      // sunday = 7
      for (int i = 0; i < tDate.weekday; i++) {
        // add padding
        allDays.add(Expanded(child: Container()));
      }
    }

    while (tDate.month == date.month) {
      // find if day has events
      bool hasEvent = false;
      for (Event e in events) {
        if (e.start == null) continue;
        if (e.start.day == tDate.day) {
          hasEvent = true;
          break;
        }
      }

      // add child
      allDays.add(Expanded(
        child: Column(
          children: [
            // container for text and background
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tDate.day == date.day
                    ? AppColors.PRIMARY_MAIN
                    : Colors.transparent,
              ),
              width: 32,
              height: 32,
              child: Center(
                child:Text(
                  '${tDate.day}',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: tDate.day == date.day
                          ? AppColors.GRAY_LIGHT[2]
                          : AppColors.GRAY_DARK[0]),
                 ),
              ),
            ),
            // indicator
            SizedBox(height: 4),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: hasEvent ? AppColors.SECONDARY_MAIN : Colors.transparent,
              ),
              width: 8,
              height: 8,
            ),
          ],
        ),// ),
      ));

      tDate = tDate.add(Duration(days: 1));
    }

    int counter = 0;

    List<Widget> rowChildren = [];

    for (int i = 0; i < allDays.length; i++) {
      counter++;

      rowChildren.add(allDays[i]);

      if (counter == 7) {
        counter = 0;
        mainChildren.add(Row(children: rowChildren));
        if (i + 1 < allDays.length) mainChildren.add(SizedBox(height: 4));
        rowChildren = [];
      }
    }

    if (rowChildren.length > 0) {
      int oSize = rowChildren.length;
      for (int i = 0; i < 7 - oSize; i++) {
        // add padding
        rowChildren.add(Expanded(child: Container()));
      }
      mainChildren.add(Row(children: rowChildren));
    }

    return Column(children: mainChildren);
  }

  @override
  Widget build(BuildContext context) {
    List<Event> events =
        Provider.of<CalendarEvents>(context).getEventsByMonth(date);

    return Container(
      // height: 382,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.GRAY_LIGHT[2],
        boxShadow: [AppEffects.DEFAULT_SHADOW],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          // header
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  '${_MONTHS[date.month - 1]} ${date.year}',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4
                      .copyWith(color: AppColors.GRAY_DARK[0])
                ),
              ),
              // Spacer(),
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                iconSize: 24,
                color: AppColors.GRAY_DARK[0],
                onPressed: onPressedLeft,
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded),
                iconSize: 24,
                color: AppColors.GRAY_DARK[0],
                onPressed: onPressedRight,
              ),
            ],
          ),
          SizedBox(height: 10),
          // days
          _buildDays(context),
          SizedBox(height: 10),
          // dates
          _buildDates(context, events),
        ],
      ),
    );
  }
}
