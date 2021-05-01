import 'package:flutter/material.dart';

import 'package:admu_student_app/screens/schedule/add_course.dart';

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
      ],
    );
  }
}
