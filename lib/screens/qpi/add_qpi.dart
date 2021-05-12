import 'package:admu_student_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/models/course.dart';
import 'package:admu_student_app/widgets/input_field.dart';
import 'package:admu_student_app/widgets/buttons.dart';
import 'package:admu_student_app/widgets/select_color.dart';

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
  String title = 'Year';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Done',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: AppColors.GRAY_LIGHT[2])),
              )
            ],
          ),
        ],
        title: IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          color: AppColors.PRIMARY_MAIN,
          padding: EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 96.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Row(
                  children: [
                    Text(
                      'Add $title QPI',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: AppColors.GRAY_LIGHT[2]),
                    )
                  ],
                ),
              ),
              ButtonRow('Year', 'Semester', 'Course', () {
                // Item 1 Clicked
                setState(() {
                  yearSelected = true;
                  semesterSelected = false;
                  courseSelected = false;

                  title = 'Year';
                });
              }, () {
                // Item 2 Clicked
                setState(() {
                  yearSelected = false;
                  semesterSelected = true;
                  courseSelected = false;

                  title = 'Semester';
                });
              }, () {
                // Item 3 Clicked
                setState(() {
                  yearSelected = false;
                  semesterSelected = false;
                  courseSelected = true;

                  title = 'Course';
                });
              }),
              SizedBox(
                height: 24,
              ),
              yearSelected ? YearAddQPI() : SizedBox(),
              semesterSelected ? SemesterAddQPI() : SizedBox(),
              courseSelected ? CourseAddQPI() : SizedBox(),
              Spacer(),
              LongButton('Delete', Colors.orange, Colors.white, () {
                Navigator.pop(context);
              })
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Year Level',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: AppColors.GRAY_LIGHT[2]),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: 181,
                child: InputField(
                  isMultiLined: false,
                  length: null,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Yearly QPI',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: AppColors.GRAY_LIGHT[2]),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: 181,
                child: InputField(
                  isMultiLined: false,
                  length: null,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SemesterAddQPI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // Main Column for Widgets
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row for Text Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text Field at the Left
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Year Level',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.GRAY_LIGHT[2]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 181,
                    child: InputField(
                      isMultiLined: false,
                      length: null,
                    ),
                  )
                ],
              ),
              // Text Field at the Right
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Semestral QPI',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.GRAY_LIGHT[2]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 181,
                    child: InputField(
                      isMultiLined: false,
                      length: null,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Semester',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: AppColors.GRAY_LIGHT[2]),
          ),
          SizedBox(
            height: 8,
          ),
          SemSelect(Colors.white, Colors.black)
        ],
      ),
    );
  }
}

class CourseAddQPI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // Main Column for Widgets
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row for Text Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text Field at the Left
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Year Level',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.GRAY_LIGHT[2]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 181,
                    child: InputField(
                      isMultiLined: false,
                      length: null,
                    ),
                  )
                ],
              ),
              // DropDown at the Right
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Letter Grade',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.GRAY_LIGHT[2]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  DropDown()
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          // 2nd row of widgets
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Semester',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.GRAY_LIGHT[2]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SemSelect(Colors.white, Colors.black),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Units',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.GRAY_LIGHT[2]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 181,
                    child: InputField(
                      isMultiLined: false,
                      length: null,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          // 3rd Row of Widgets
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Color Code',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: AppColors.GRAY_LIGHT[2]),
              ),
              SizedBox(
                height: 10,
              ),
              SelectColor()
            ],
          )
        ],
      ),
    );
  }
}
