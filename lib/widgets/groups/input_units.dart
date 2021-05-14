import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/widgets/input_field.dart';

class InputUnitsGroup extends StatelessWidget {
  final TextEditingController controller;

  InputUnitsGroup(this.controller);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          controller: controller,
          isMultiLined: false,
          length: null,
        ),
      ],
    );
  }
}
