import 'package:flutter/material.dart';

import 'package:admu_student_app/models/course.dart';

class AddQPIPage extends StatefulWidget {
  final bool isEditing;

  // template, to add a new course
  final int yearNum;
  final int semNum;

  // for editing
  final Course course;

  AddQPIPage({this.isEditing, this.yearNum, this.semNum, this.course});

  @override
  _AddQPIPageState createState() => _AddQPIPageState();
}

class _AddQPIPageState extends State<AddQPIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('add/edit qpi'),
    );
  }
}
