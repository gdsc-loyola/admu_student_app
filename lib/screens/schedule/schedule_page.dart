import 'package:flutter/material.dart';

import 'package:admu_student_app/widgets/schedule/schedule_timetable.dart';

import 'package:admu_student_app/widgets/help_button.dart';
class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<bool> colorSelected = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 48),
      child: Column(
        children: [
          Expanded(
            // sample data
            child: ScheduleTimetable(yearNum: 1, semNum: 2, qtrNum: 4),
          ),
        ],
      ),
    );
  }
}
