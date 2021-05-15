import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/widgets/groups/input_code.dart';
import 'package:admu_student_app/widgets/groups/input_units.dart';
import 'package:admu_student_app/widgets/groups/input_year.dart';
import 'package:admu_student_app/widgets/groups/select_semester.dart';
import 'package:admu_student_app/widgets/buttons.dart';
import 'package:admu_student_app/widgets/select_color.dart';

class CourseAddQPI extends StatelessWidget {
  final TextEditingController yearController;
  final TextEditingController unitsController;
  final TextEditingController codeController;

  CourseAddQPI({
    @required this.yearController,
    @required this.unitsController,
    @required this.codeController,
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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text Field at the Left
              Expanded(child: InputYearGroup(yearController)),
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
                    GradeDropDown(),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // 2nd row of widgets
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: SelectSemesterGroup()),
              SizedBox(width: 20),
              Expanded(child: InputUnitsGroup(unitsController)),
            ],
          ),
          SizedBox(height: 16),
          // temporary for code
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: InputCodeGroup(codeController)),
              SizedBox(width: 20),
              Expanded(child: Container()),
            ],
          ),
          Text(
            'Color Code',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: AppColors.GRAY_LIGHT[2]),
          ),
          SizedBox(height: 10),
          SelectColor(),
        ],
      ),
    );
  }
}
