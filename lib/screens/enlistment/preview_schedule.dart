import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/models/_all_courses.dart';
import 'package:admu_student_app/models/_course.dart';
import 'package:admu_student_app/widgets/schedule/schedule_timetable.dart';

class PreviewSchedule extends StatelessWidget {
  final List<Course> subjects;

  PreviewSchedule(this.subjects);

  @override
  Widget build(BuildContext context) {
    Map<String, int> latestSched =
        Provider.of<AllCourses>(context, listen: false)
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
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 40, 16, 40),
        child: ScheduleTimetable(latestSched, subjects: subjects),
      ),
    );
  }
}
