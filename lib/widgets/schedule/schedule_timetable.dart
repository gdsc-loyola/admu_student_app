import 'package:admu_student_app/models/class_schedule.dart';
import 'package:admu_student_app/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleTimetable extends StatelessWidget {
  final int yearNum; // if 0, enlistment
  final int semNum; // if 0, enlistment
  final int qtrNum; // if 0, enlistment

  ScheduleTimetable({
    @required this.yearNum,
    @required this.semNum,
    this.qtrNum = 0,
  });

  final List<String> DAYS = ['MO', 'TU', 'WE', 'TH', 'FR', 'SA'];

  Widget _buildBackground(BuildContext context, Map data) {
    List<Widget> children = [Container(height: 32)];

    for (int i = data['start']; i <= data['end']; i++)
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

  Widget _buildTimetable(BuildContext context, Map data) {
    List<Widget> cols = [];

    // generate hour column
    List<Widget> hourCol = [Container(height: 32)];
    for (int i = data['start']; i <= data['end']; i++)
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
      List<Subject> subjs = data['subjects'][i];
      for (int j = 0; j < subjs.length; j++) {
        // colWidgets.add();
        if (j == 0) {
          // add spacer before first class

          int minsbw = ClassSchedule.getMinutesBetween(
              data['start'] * 100, subjs[j].start);

          if (minsbw > 0)
            colWidgets.add(Flexible(flex: minsbw, child: Container()));
        } else {
          // spacer between classes

          int minsbw =
              ClassSchedule.getMinutesBetween(subjs[j - 1].end, subjs[j].start);

          if (minsbw > 0)
            colWidgets.add(Flexible(flex: minsbw, child: Container()));
        }

        int duration =
            ClassSchedule.getMinutesBetween(subjs[j].start, subjs[j].end);

        if (duration > 0)
          colWidgets.add(
            Flexible(
              flex: duration,
              child: _SubjectBlock(
                color: subjs[j].color,
                courseCode: subjs[j].code,
              ),
            ),
          );
      }

      // add space between last subject and end
      if (subjs.length > 0) {
        int lastmin = ClassSchedule.getMinutesBetween(
            subjs[subjs.length - 1].end, (data['end'] + 1) * 100);

        if (lastmin > 0)
          colWidgets.add(Flexible(flex: lastmin, child: Container()));
      }

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
    Map<String, dynamic> data = Provider.of<ClassSchedule>(context)
        .getSubjects(yearNum, semNum, qtrNum);

    return Stack(
      children: [
        // no data, empty state
        // Positioned.fill(child: Container(color: Colors.green)),
        // background
        Positioned.fill(child: _buildBackground(context, data)),
        // foreground, timetable
        Positioned.fill(child: _buildTimetable(context, data)),
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
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(8)), // original 7
      ),
      padding: EdgeInsets.all(4),
      child: Center(
        child: Text(
          courseCode,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
