import 'package:admu_student_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/screens/calendar/calendar_tab.dart';
import 'package:admu_student_app/screens/calendar/tasks_tab.dart';

class CalendarPage extends StatefulWidget {
  final DateTime date;
  final Function(DateTime) onDateChange;

  CalendarPage({this.date, this.onDateChange});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _date;
  bool isMonth = false;

  @override
  void initState() {
    super.initState();

    if (widget.date != null)
      _date = widget.date;
    else
      _date = DateTime.now();
  }

  void _onDateChange(DateTime date) {
    setState(() {
      _date = date;
    });

    if (widget.onDateChange != null) widget.onDateChange(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 58,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 6,
                          color: isMonth
                              ? AppColors.SECONDARY_MAIN
                              : AppColors.GRAY_LIGHT[0],
                        ),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isMonth = true;
                        });
                      },
                      child: Ink(
                        child: Center(
                          child: Text(
                            'Calendar',
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: isMonth
                                          ? AppColors.SECONDARY_MAIN
                                          : AppColors.GRAY_LIGHT[0],
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 58,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 6,
                          color: isMonth
                              ? AppColors.GRAY_LIGHT[0]
                              : AppColors.SECONDARY_MAIN,
                        ),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isMonth = false;
                        });
                      },
                      child: Ink(
                        child: Center(
                          child: Text(
                            'Tasks',
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: isMonth
                                          ? AppColors.GRAY_LIGHT[0]
                                          : AppColors.SECONDARY_MAIN,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
              child: Column(
                children: [
                  isMonth
                      ? CalendarTab(date: _date, onDateChange: _onDateChange)
                      : TasksTab(date: _date, onDateChange: _onDateChange)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
