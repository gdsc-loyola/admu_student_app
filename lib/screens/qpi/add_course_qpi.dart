import 'package:flutter/material.dart';

import 'package:admu_student_app/models/course.dart';

class AddCourseQPIPage extends StatefulWidget {
  final bool isEditing;

  // template, to add a new course
  final int yearNum;
  final int semNum;

  // for editing
  final Course course;

  AddCourseQPIPage(
      {@required this.isEditing, this.yearNum, this.semNum, this.course});

  @override
  _AddCourseQPIPageState createState() => _AddCourseQPIPageState();
}

class _AddCourseQPIPageState extends State<AddCourseQPIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('add/edit course qpi'),
    );
  }
}
