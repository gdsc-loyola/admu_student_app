import 'package:flutter/material.dart';

class ScheduleTimetable extends StatelessWidget {
  // 0 = enlistment
  // 1 = sem OR q1 OR q3
  // 2 = sem OR q2 OR q4
  final int type;

  ScheduleTimetable({@required this.type});

  final List<String> DAYS = ['MO', 'TU', 'WE', 'TH', 'FR', 'SA'];

  Widget _buildBackground(BuildContext context) {
    // get first and last hours
    int firstHr = 9;
    int lastHr = 15;

    List<Widget> children = [Container(height: 32)];

    for (int i = firstHr; i <= lastHr; i++)
      children.add(
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: Color(0xFFEEEEEE),
                ),
              ),
            ),
          ),
        ),
      );

    return Column(children: children);
  }

  Widget _buildTimetable(BuildContext context) {
    // get schedule, list of subjects from provider

    // get first and last hours
    int firstHr = 9;
    int lastHr = 15;

    List<Widget> cols = [];

    // generate hour column
    List<Widget> hourCol = [Container(height: 32)];
    for (int i = firstHr; i <= lastHr; i++)
      hourCol.add(
        Expanded(
          child: Container(
            width: 40,
            padding: EdgeInsets.only(left: 1, top: 1),
            child: Text(
              i.toString().padLeft(2, '0'),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.black),
            ),
          ),
        ),
      );
    cols.add(Column(children: hourCol));

    // generate for each column, timetable
    for (int i = 0; i < DAYS.length; i++) {
      List<Widget> colWidgets = [];

      // day
      colWidgets.add(
        Container(
          height: 32, // original 33
          child: Center(
            child: Text(
              DAYS[i],
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Color(0xFF6C6C6C)),
            ),
          ),
        ),
      );

      // build schedule
      colWidgets.add(
        Expanded(child: Container()),
      );

      cols.add(
        Expanded(
          child: Column(
            children: colWidgets,
          ),
        ),
      );
    }

    return Row(children: cols);
  }

  @override
  Widget build(BuildContext context) {
    // get schedule, list of subjects from provider

    // get first and last hours
    // int firstHr = 9;
    // int lastHr = 15;

    return Stack(
      children: [
        // testing bounds
        // Positioned.fill(child: Container(color: Colors.green)),
        // background
        Positioned.fill(child: _buildBackground(context)),
        // foreground, timetable
        Positioned.fill(child: _buildTimetable(context)),
      ],
    );
  }
}

class _SubjectBlock extends StatelessWidget {
  final Color color;
  final String courseCode;

  _SubjectBlock({@required this.color, this.courseCode = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)), // original 7
      ),
      padding: EdgeInsets.all(4),
      child: Center(
        child: Text(
          courseCode,
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
