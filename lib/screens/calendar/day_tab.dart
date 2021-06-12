import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_strings.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/widgets/calendar/calendar.dart';
import 'package:admu_student_app/widgets/calendar/event_card_small.dart';

class DayTab extends StatefulWidget {
  final DateTime date;
  final Function(DateTime) onDateChange;

  DayTab({this.date, this.onDateChange});

  @override
  _DayTabState createState() => _DayTabState();

  
}

class _DayTabState extends State<DayTab> {
  DateTime _date;
  PageController _pageCtrl;

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
  
  dynamic _getDates() {
  // Take the input year, month number, and pass it inside DateTime()
  var now = DateTime(2020, 7);
  
  // Getting the total number of days of the month
  var totalDays = daysInMonth(now);
  
  // Stroing all the dates till the last date
  // since we have found the last date using generate
  var listOfDates = new List<int>.generate(totalDays, (i) => i + 1);
  return listOfDates;
}

dynamic _getNow() {
  var now = DateTime.now();
  return now.day;
}

// this returns the last date of the month using DateTime
int daysInMonth(DateTime date){
  var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
  var firstDayNextMonth = new DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, firstDayThisMonth.day);
  return firstDayNextMonth.difference(firstDayThisMonth).inDays;
}

  @override
  Widget build(BuildContext context) {
    
    // inside the Widget build, dispose it AND create a new controller - important for screen sizes
    if (_pageCtrl != null) _pageCtrl.dispose();
    _pageCtrl = PageController(
        initialPage: _getNow(), // the date today 
        viewportFraction: 150 / MediaQuery.of(context).size.width);
    _pageCtrl.addListener(
      () {
        // check if _pageCtrl.page is an integer - means that the scrolling has locked into position
        // you can set state here by setting the DateTime variable -- no need to do this one
        print(_pageCtrl.page);
      },
    );

    List<Event> _events =
        Provider.of<CalendarEvents>(context).getEventsByDay(_date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 27),
        // testing
        SizedBox(
          height:
              112, // this should be the height of the time card (the purple box)
          child: PageView.builder(
              controller: _pageCtrl,
              itemCount: _getDates().length, // example only
              itemBuilder: (_, index) {
                return Container(
                  // replace with the time card
                  color: AppColors.PRIMARY_MAIN,
                  width: 72,
                  height: 112,
                  // decoration:
                  //     BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  margin: EdgeInsets.symmetric(
                      horizontal: 25), // space between two cards divided by two
                  child: Center(child: Text('$index')),
                );
              }),
        ),
        // Calendar Widget
        // CalendarMonth(
        //   date: _date,
        //   onDateChange: (DateTime date) {
        //     setState(() {
        //       _date = date;
        //     });

        //     if (widget.onDateChange != null) widget.onDateChange(_date);
        //   },
        // ),
        SizedBox(height: 16),
        // to get the string of the date (Ex. Tuesday, June 15)
        Text(
          _getDateString(),
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: AppColors.PRIMARY_ALT),
        ),
        SizedBox(height: 8),
        // list of events
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
