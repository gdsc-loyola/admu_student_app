import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_strings.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/widgets/calendar/event_card.dart';
import 'package:admu_student_app/widgets/home/empty_state.dart';

class DayTab extends StatefulWidget {
  final DateTime date;
  final Function(DateTime) onDateChange;

  DayTab({this.date, this.onDateChange});

  @override
  _DayTabState createState() => _DayTabState();
}

class _DayTabState extends State<DayTab> {
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

  String _getDateString() {
    DateTime now = DateTime.now();

    if (now.year == _date.year &&
        now.month == _date.month &&
        now.day == _date.day)
      return 'Today';
    else
      // how to get the date strings
      return '${AppStrings.DAYS[_date.weekday - 1]}, ${AppStrings.MONTHS[_date.month - 1]} ${_date.day}';
  }

  // Tests

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
    // inside the Widget build, dispose it AND create a new controller - important for screen sizes
    if (_pageCtrl != null) _pageCtrl.dispose();
    _pageCtrl = PageController(
        initialPage:
            (_getNow().month == _date.month && _getNow().year == _date.year)
                ? _getNow().day - 1
                : 0, // the date today
        viewportFraction: 150 / MediaQuery.of(context).size.width);
    _pageCtrl.addListener(
      () {
        // check if _pageCtrl.page is an integer - means that the scrolling has locked into position
        // you can set state here by setting the DateTime variable -- no need to do this one
        setState(() {
          (_pageCtrl.page is int)
              ? _pageCtrlInt = _pageCtrl.page.toInt()
              : _pageCtrlInt = null;
          (_pageCtrl.page is int)
              ? _date = DateTime(_date.year, _date.month, _pageCtrlInt + 1)
              : _date = _date;
        });

        if (widget.onDateChange != null) widget.onDateChange(_date);

        // (_pageCtrl.page is int) ? print(_date) : print('null');
      },
    );

    List<Event> _events =
        Provider.of<CalendarEvents>(context).getEventsByDay(_date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 36),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined),
                onPressed: () {
                  setState(() {
                    // minus date
                    _date = DateTime(_date.year, _date.month - 1, 1);
                    (_getNow().month == _date.month &&
                            _getNow().year == _date.year)
                        ? _date = _getNow()
                        : _date = DateTime(_date.year, _date.month, 1);

                    if (widget.onDateChange != null) widget.onDateChange(_date);

                    _pageCtrl.jumpToPage(_date.day - 1);
                  });
                }),
            Center(
              child: Text(
                '${AppStrings.MONTHS[_date.month - 1]} ${_date.year}',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: AppColors.GRAY_DARK[0]),
              ),
            ),
            IconButton(
                icon: Icon(Icons.arrow_forward_ios_outlined),
                onPressed: () {
                  setState(() {
                    // add date
                    _date = DateTime(_date.year, _date.month + 1, 1);
                    (_getNow().month == _date.month &&
                            _getNow().year == _date.year)
                        ? _date = _getNow()
                        : _date = DateTime(_date.year, _date.month, 1);

                    if (widget.onDateChange != null) widget.onDateChange(_date);

                    _pageCtrl.jumpToPage(_date.day - 1);
                  });
                })
          ],
        ),
        SizedBox(height: 27),

        // testing
        SizedBox(
          height: 112,
          child: PageView.builder(
            controller: _pageCtrl,
            itemCount: _getDates().length,
            itemBuilder: (_, index) {
              _dateAll = DateTime(_date.year, _date.month, index + 1);

              bool isDate = _date.year == _dateAll.year &&
                  _date.month == _dateAll.month &&
                  _date.day == _dateAll.day;

              return Container(
                // replace with the time card
                width: 72,
                height: 112,
                decoration: BoxDecoration(
                    color: isDate
                        ? AppColors.PRIMARY_MAIN
                        : AppColors.GRAY_LIGHT[0],
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${DateFormat('EEE').format(_dateAll).toUpperCase()}',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: isDate
                              ? AppColors.GRAY_LIGHT[2]
                              : AppColors.GRAY_DARK[2]),
                    ),
                    Text(
                      '${DateFormat('dd').format(_dateAll)}',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: isDate
                              ? AppColors.GRAY_LIGHT[2]
                              : AppColors.GRAY_DARK[2]),
                    ),
                  ],
                )),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        /*Text(
          _getDateString(),
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: AppColors.PRIMARY_ALT),
        ),
        SizedBox(height: 8),*/
        _events.length > 0
            ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _events.length,
                itemBuilder: (_, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: EventCard(
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
