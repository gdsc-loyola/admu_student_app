import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_strings.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/widgets/calendar/event_card_compact.dart';
import 'package:admu_student_app/widgets/calendar/calendar.dart';

class TasksTab extends StatefulWidget {
  final DateTime date;
  final Function(DateTime) onDateChange;

  TasksTab({this.date, this.onDateChange});

  @override
  _TasksTabState createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime _date, _dateAll;
  PageController _pageCtrl;
  int _pageCtrlInt;

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

  void _onClickMonth(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder: (context, _, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: (MediaQuery.of(context).size.height) * 0.30),
              CalendarMonth(
                onDateChange: (DateTime date) {
                  setState(() {
                    _date = date;
                  });

                  if (widget.onDateChange != null) widget.onDateChange(_date);
                },
              )
            ],
          );
        });
  }

  dynamic _getDates() {
    // Take the input year, month number, and pass it inside DateTime()
    var now = _date;

    // Getting the total number of days of the month
    var totalDays = daysInMonth(now);

    var listOfDates = new List<int>.generate(totalDays, (i) => i + 1);
    return listOfDates;
  }

  dynamic _getNow() {
    var now = DateTime.now();
    return now;
  }

// this returns the last date of the month using DateTime
  int daysInMonth(DateTime _date) {
    var firstDayThisMonth = new DateTime(_date.year, _date.month, _date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  @override
  Widget build(BuildContext context) {
    if (_pageCtrl != null) _pageCtrl.dispose();
    _pageCtrl = PageController(
        initialPage: _date.day - 1,
        // (_getNow().month == _date.month && _getNow().year == _date.year)
        //     ? _getNow().day - 1
        //     : 0, // the date today
        viewportFraction: 150 / MediaQuery.of(context).size.width);
    _pageCtrl.addListener(
      () {
        setState(() {
          _pageCtrlInt = _pageCtrl.page.round();

          _date = DateTime(_date.year, _date.month, _pageCtrlInt + 1);

          // (_pageCtrl.page is int)
          //     ? _pageCtrlInt = _pageCtrl.page.toInt()
          //     : _pageCtrlInt = null;
          // (_pageCtrl.page is int)
          //     ? _date = DateTime(_date.year, _date.month, _pageCtrlInt + 1)
          //     : _date = _date;
        });

        if (widget.onDateChange != null) widget.onDateChange(_date);
      },
    );

    /*List<Event> _events =
        Provider.of<CalendarEvents>(context).getEventsByDay(_date);*/

    return Column(
      children: [
        InkWell(
            child: Row(children: [
          Text(
            '${AppStrings.MONTHS[_date.month - 1]} ',
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: AppColors.GRAY_DARK[0]),
          ),
          IconButton(
            onPressed: () => _onClickMonth(context),
            icon: Icon(Icons.expand_more_rounded),
          )
        ])),
        SizedBox(height: 27),
        Container(
            child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _getDates().length,
          itemBuilder: (_, index) {
            _dateAll = DateTime(_date.year, _date.month, index + 1);
            bool isDate = _date.year == _dateAll.year &&
                _date.month == _dateAll.month &&
                _date.day == _dateAll.day;
            return Container(
                child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Provider.of<CalendarEvents>(context)
                                .getEventsByDay(_dateAll)
                                .length >
                            0
                        ? Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${DateFormat('EEE').format(_dateAll)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            color: isDate
                                                ? AppColors.PRIMARY_MAIN
                                                : AppColors.GRAY_DARK[0]),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        color: isDate
                                            ? AppColors.PRIMARY_MAIN
                                            : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '${DateFormat('dd').format(_dateAll)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            .copyWith(
                                                color: isDate
                                                    ? AppColors.GRAY_LIGHT[2]
                                                    : AppColors.GRAY_DARK[0]),
                                      )),
                                ],
                              )
                            ],
                          )
                        : Container(),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Provider.of<CalendarEvents>(context)
                      .getEventsByDay(_dateAll)
                      .length,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      child: CompactEventCard(
                        event: Provider.of<CalendarEvents>(context)
                            .getEventsByDay(_dateAll)[index],
                        onMark: () => setState(() {}),
                      ),
                    );
                  },
                ))
              ],
            ));
          },
        )),
        SizedBox(height: 16),
      ],
      /*Text(
          _getDateString(),
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: AppColors.PRIMARY_ALT),
        ),
        SizedBox(height: 8),*/
    );
  }
}
