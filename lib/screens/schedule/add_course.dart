import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/widgets/groups/select_date.dart';
import 'package:admu_student_app/widgets/groups/select_days.dart';
import 'package:admu_student_app/widgets/groups/select_time.dart';

class AddCoursePage extends StatefulWidget {
  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 48.0),
        child: Container(
          color: AppColors.PRIMARY_MAIN,
          child: Column(
            children: [
              SelectDaysGroup(),
              SelectDateGroup('Label'),
              SelectTimeGroup('Label'),
              Row(
                children: [
                  Expanded(child: SelectDateGroup('Label')),
                  SizedBox(width: 20), // temp
                  Expanded(child: SelectTimeGroup('Label')),
                ],
              ),
              Row(
                children: [
                  Expanded(child: SelectTimeGroup('Label')),
                  SizedBox(width: 20), // temp
                  Expanded(child: SelectTimeGroup('Label')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
