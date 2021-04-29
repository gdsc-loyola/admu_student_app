import 'package:flutter/material.dart';

import 'package:admu_student_app/screens/schedule/enlistment/add_course.dart';

class EnlistmentSemesterPage extends StatefulWidget {
  @override
  _EnlistmentSemesterPageState createState() => _EnlistmentSemesterPageState();
}

class _EnlistmentSemesterPageState extends State<EnlistmentSemesterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('this is the enlistment semester page'),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => AddCoursePage()),
              );
            },
            child: Text('add new course'),
          ),
        ],
      ),
    );
  }
}
