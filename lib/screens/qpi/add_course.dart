import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/widgets/groups/input_group.dart';
import 'package:admu_student_app/widgets/groups/select_semester.dart';
import 'package:admu_student_app/widgets/qpi/grade_drop_down.dart';
import 'package:admu_student_app/widgets/groups/select_color.dart';

class CourseAddQPI extends StatelessWidget {
  final TextEditingController yearController;
  final TextEditingController unitsController;
  final TextEditingController codeController;

  final Color color;
  final Function(Color) onColorChange;

  final int gradeVal;
  final Function(int) onGradeChange;

  final int sem;
  final Function(int) onSemChange;

  CourseAddQPI({
    @required this.yearController,
    @required this.unitsController,
    @required this.codeController,
    this.color,
    this.onColorChange,
    this.gradeVal,
    this.onGradeChange,
    this.sem,
    this.onSemChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // Main Column for Widgets
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row for Text Fields
          Row(
            children: [
              // Text Field at the Left
              Expanded(
                child: InputGroup(
                  'Year Level',
                  yearController,
                  hint: '1',
                  length: 1,
                ),
              ),
              SizedBox(width: 20),
              // DropDown at the Right
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Letter Grade',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: AppColors.GRAY_LIGHT[2]),
                    ),
                    SizedBox(height: 8),
                    GradeDropDown(
                      selected: gradeVal,
                      onValueChange: onGradeChange,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // 2nd row of widgets
          Row(
            children: [
              Expanded(
                child: InputGroup(
                  'Units',
                  unitsController,
                  hint: '3',
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: SelectSemesterGroup(
                  selected: sem,
                  onValueChange: onSemChange,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InputGroup(
                  'Course Code',
                  codeController,
                  hint: 'COURSE101',
                ),
              ),
              SizedBox(width: 20),
              Expanded(child: Container()),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Color Code',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: AppColors.GRAY_LIGHT[2]),
          ),
          SizedBox(height: 8),
          SelectColor(
            color: color,
            onColorChange: onColorChange,
          ),
        ],
      ),
    );
  }
}
