import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/widgets/input_field.dart';

class InputGroup extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isMultilined;
  final int length;

  InputGroup(
    this.label,
    this.controller, {
    this.isMultilined = false,
    this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: AppColors.GRAY_LIGHT[2]),
        ),
        SizedBox(height: 8),
        InputField(
          controller: controller,
          // isMultiLined: false,
          // length: null,
          isMultiLined: isMultilined,
          length: length,
        ),
      ],
    );
  }
}
