import 'package:admu_student_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/models/course.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class AddQPIPage extends StatefulWidget {
  // final bool isEditing;

  // // template, to add a new course
  // final int yearNum;
  // final int semNum;

  // // for editing
  // final Course course;

  // AddQPIPage({this.isEditing, this.yearNum, this.semNum, this.course});

  @override
  _AddQPIPageState createState() => _AddQPIPageState();
}

class _AddQPIPageState extends State<AddQPIPage> {
  bool yearSelected = true;
  bool semesterSelected = false;
  bool courseSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD QPI'),
      ),
      body: Center(
        child: Container(
          color: AppColors.PRIMARY_MAIN,
          padding: EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [Text('Add Year QPI')],
              ),
              ButtonRow('Year', 'Semester', 'Course', () {
                setState(() {
                  yearSelected = true;
                  semesterSelected = false;
                  courseSelected = false;
                });
              }, () {
                setState(() {
                  yearSelected = false;
                  semesterSelected = true;
                  courseSelected = false;
                });
              }, () {
                setState(() {
                  yearSelected = false;
                  semesterSelected = false;
                  courseSelected = true;
                });
              }),
              yearSelected ? YearAddQPI() : SizedBox(),
              semesterSelected ? SemesterAddQPI() : SizedBox(),
              courseSelected ? CourseAddQPI() : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class YearAddQPI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      color: Colors.red,
      child: Text('ADD YEAR QPI HERE'),
    );
  }
}

class SemesterAddQPI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      color: Colors.green,
      child: Text('ADD SEMESTER QPI HERE'),
    );
  }
}

class CourseAddQPI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      color: Colors.blue,
      child: Text('ADD COURSE QPI HERE'),
    );
  }
}
