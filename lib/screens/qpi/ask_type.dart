import 'package:flutter/material.dart';

import 'package:admu_student_app/screens/qpi/add_course_qpi.dart';
import 'package:admu_student_app/screens/qpi/add_semester_qpi.dart';
import 'package:admu_student_app/screens/qpi/add_year_qpi.dart';

class AskQPITypePage extends StatefulWidget {
  @override
  _AskQPITypePageState createState() => _AskQPITypePageState();
}

class _AskQPITypePageState extends State<AskQPITypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('Please choose one'),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => AddYearQPIPage()),
              );
            },
            child: Text('Yearly'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => AddSemesterQPIPage()),
              );
            },
            child: Text('Semestral'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => AddCourseQPIPage(isEditing: false)),
              );
            },
            child: Text('Course'),
          ),
        ],
      ),
    );
  }
}
