import 'package:flutter/material.dart';

import 'package:admu_student_app/screens/enlistment/add_course.dart';

class EnlistmentClassesPage extends StatefulWidget {
  @override
  _EnlistmentClassesPageState createState() => _EnlistmentClassesPageState();
}

class _EnlistmentClassesPageState extends State<EnlistmentClassesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('this is the enlistment classes page'),
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
