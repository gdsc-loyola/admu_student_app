import 'package:flutter/material.dart';

import 'package:admu_student_app/screens/schedule/add_course.dart';
import 'package:admu_student_app/screens/schedule/enlistment/enlistment_page.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => AddCoursePage()),
            );
          },
          child: Text('add course'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => EnlistmentPage()),
            );
          },
          child: Text('enlistment page'),
        ),
      ],
    );
  }
}
