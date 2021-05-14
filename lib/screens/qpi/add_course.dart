import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/widgets/buttons.dart';
import 'package:admu_student_app/widgets/input_field.dart';
import 'package:admu_student_app/widgets/select_color.dart';

class CourseAddQPI extends StatelessWidget {
  final TextEditingController yearController;
  final TextEditingController unitsController;

  CourseAddQPI({
    @required this.yearController,
    @required this.unitsController,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Year Level',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: AppColors.GRAY_LIGHT[2]),
                    ),
                    SizedBox(height: 8),
                    InputField(
                      controller: yearController,
                      isMultiLined: false,
                      length: null,
                    ),
                  ],
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Semester',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: AppColors.GRAY_LIGHT[2]),
                    ),
                    SizedBox(height: 8),
                    SemSelect(),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Units',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: AppColors.GRAY_LIGHT[2]),
                    ),
                    SizedBox(height: 8),
                    InputField(
                      controller: unitsController,
                      isMultiLined: false,
                      length: null,
                    ),
                  ],
                ),
              ),
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
          SizedBox(height: 10),
          SelectColor(),
        ],
      ),
    );
  }
}
