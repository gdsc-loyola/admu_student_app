import 'package:flutter/material.dart';

import 'package:admu_student_app/models/semester.dart';
import 'package:admu_student_app/screens/qpi/ask_type.dart';

class SemesterPage extends StatefulWidget {
  final Semester sem;

  SemesterPage({@required this.sem});

  @override
  _SemesterPageState createState() => _SemesterPageState();
}

class _SemesterPageState extends State<SemesterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    // builder: (_) => AddCourseQPIPage(isEditing: false)),
                    builder: (_) => AskQPITypePage()),
              );
            },
            child: Text('add new course'),
          ),
          Text('list of courses'),
        ],
      ),
    );
  }
}
