import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/constants/app_strings.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';

class CalendarMonth extends StatefulWidget {
  final DateTime date;
  final Function(DateTime) onDateChange;

  CalendarMonth({
    this.date,
    this.onDateChange,
  });

  @override
  _CalendarMonthState createState() => _CalendarMonthState();
}

class _CalendarMonthState extends State<CalendarMonth> {
  DateTime _date;

  @override
  void initState() {
    super.initState();

    if (widget.date != null)
      _date = widget.date;
    else
      _date = DateTime.now();
  }

  Widget _buildDays(BuildContext context) {
    List<Widget> children = [];

    for (int i = 0; i < AppStrings.DAYS_SHORT.length; i++)
      children.add(
        Expanded(
          child: Center(
            child: Text(
              AppStrings.DAYS_SHORT[i],
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

    DateTime tDate = DateTime(_date.year, _date.month);

    // build per row
    List<Widget> allDays = [];

    if (tDate.weekday != DateTime.sunday) {
      // sunday = 7
      for (int i = 0; i < tDate.weekday; i++) {
        // add padding
        allDays.add(Expanded(child: Container()));
      }
    }

    // generate days
    List<DateTime> daysOfTheMonth = [];

    while (tDate.month == _date.month) {
      daysOfTheMonth.add(tDate);
      tDate = tDate.add(Duration(days: 1));
    }

    for (DateTime dt in daysOfTheMonth) {
      // find if day has events
      bool hasEvent = false;
      for (Event e in events) {
        if (e.start != null && e.start.day == dt.day) {
          hasEvent = true;
          break;
        } else if (e.end != null && e.end.day == dt.day) {
          hasEvent = true;
          break;
        }
      }

      // add child
      allDays.add(Expanded(
        child: Column(
          children: [
            // container for text and background
            InkWell(
              onTap: () {
                setState(() {
                  // change date
                  _date = dt;

                  if (widget.onDateChange != null) widget.onDateChange(_date);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: dt.day == _date.day
                      ? AppColors.PRIMARY_MAIN
                      : Colors.transparent,
                  border: Border.all(
                    color: (dt.year == DateTime.now().year) &&
                            (dt.month == DateTime.now().month) &&
                            (dt.day == DateTime.now().day)
                        ? AppColors.PRIMARY_MAIN
                        : Colors.transparent,
                    width: 1.0,
                  ),
                ),
                width: 32,
                height: 32,
                child: Center(
                  child: Text(
                    '${dt.day}',
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: dt.day == _date.day
                            ? AppColors.GRAY_LIGHT[2]
                            : AppColors.GRAY_DARK[0],
                        fontWeight: (dt.year == DateTime.now().year) &&
                                (dt.month == DateTime.now().month) &&
                                (dt.day == DateTime.now().day)
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                ),
              ),
            ),

            // dot indicator
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
        ),
      ));
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
        Provider.of<CalendarEvents>(context).getEventsByMonth(_date);

    return Material(
        child: Ink(
      // height: 382
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        boxShadow: [AppEffects.SHADOW_FOR_WHITE],
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
                    '${AppStrings.MONTHS[_date.month - 1]} ${_date.year}',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: AppColors.GRAY_DARK[0])),
              ),
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                iconSize: 24,
                color: AppColors.GRAY_DARK[0],
                onPressed: () {
                  setState(() {
                    // minus date
                    _date = DateTime(_date.year, _date.month - 1, 1);
                    if (widget.onDateChange != null) widget.onDateChange(_date);
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded),
                iconSize: 24,
                color: AppColors.GRAY_DARK[0],
                onPressed: () {
                  setState(() {
                    // add date
                    _date = DateTime(_date.year, _date.month + 1, 1);
                    if (widget.onDateChange != null) widget.onDateChange(_date);
                  });
                },
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
    ));
  }
}
