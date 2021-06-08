import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/models/class_schedule.dart';
import 'package:admu_student_app/widgets/schedule/schedule_timetable.dart';
import 'package:admu_student_app/widgets/help_button.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int _yearNum = 1;
  int _semNum = 2;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> scheds =
        Provider.of<ClassSchedule>(context).getSchedules();

    return Container(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 48),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: scheds.length,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _yearNum = scheds[index]['yearNum'];
                    _semNum = scheds[index]['semNum'];
                  });
                },
                child: Text(scheds[index]['scheduleName']),
              );
            },
          ),
          Expanded(
            child: ScheduleTimetable(yearNum: _yearNum, semNum: _semNum),
          ),
        ],
      ),
    );
  }
}
