import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/models/class_schedule.dart';
import 'package:admu_student_app/models/subject.dart';
import 'package:admu_student_app/screens/add_class.dart';
import 'package:admu_student_app/widgets/home/empty_state.dart';
import 'package:admu_student_app/widgets/modals/alert.dart';
import 'package:admu_student_app/widgets/modals/custom_snack_bar.dart';

class ScheduleTimetable extends StatelessWidget {
  final Map<String, int> schedInfo;

  final List<Subject> subjects;

  ScheduleTimetable(this.schedInfo, {this.subjects});

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
              child: _SubjectBlock(subjs[j]),
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

      // skip sat if no classes?
      if (i == 5 && subjs.length == 0) continue;

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
    Map<String, dynamic> data = Provider.of<ClassSchedule>(context).getSubjects(
        schedInfo['yearNum'],
        schedInfo['semNum'],
        schedInfo['qtrNum'],
        subjects);

    return Stack(
      children: [
        // background
        Positioned.fill(child: _buildBackground(context, data)),

        // foreground, timetable
        Positioned.fill(child: _buildTimetable(context, data)),

        // no data, empty state
        if (data['isEmpty'])
          Center(
              child: EmptyState(
                  topText: 'No Schedule Yet',
                  bottomText:
                      'Create your classes by tapping the + button at the top right corner!')),
      ],
    );
  }
}

class _SubjectBlock extends StatelessWidget {
  final Subject subject;

  _SubjectBlock(this.subject);

  @override
  Widget build(BuildContext context) {
    Widget block = Container(
      decoration: BoxDecoration(
        color: subject.color,
        borderRadius: BorderRadius.all(Radius.circular(8)), // original 7
      ),
      padding: EdgeInsets.all(4),
      child: Center(
        child: Text(
          subject.code,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );

    return GestureDetector(
      onLongPress: () async {
        await AlertModal.showAlert(
          context,
          header: 'Delete ${subject.code}?',
          onAccept: () {
            Provider.of<ClassSchedule>(context, listen: false)
                .deleteSubject(subject);

            CustomSnackBar.showSnackBar(context, 'Class deleted!');
          },
        );
      },
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AddClassPage(
              isEditing: true,
              id: subject.id,
              subject: subject,
            ),
          ),
        );
      },
      child: block,
    );
  }
}
