import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/models/class_schedule.dart';
import 'package:admu_student_app/models/subject.dart';
import 'package:admu_student_app/widgets/schedule/schedule_timetable.dart';

class PreviewSchedule extends StatelessWidget {
  final List<Subject> subjects;

  PreviewSchedule(this.subjects);

  @override
  Widget build(BuildContext context) {
    Map<String, int> latestSched =
        Provider.of<ClassSchedule>(context, listen: false)
            .getEnlistmentScheduleDetails();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          iconSize: 32,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ScheduleTimetable(latestSched, subjects: subjects),
    );
  }
}
