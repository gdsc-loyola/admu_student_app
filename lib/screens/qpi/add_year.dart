import 'package:flutter/material.dart';

import 'package:admu_student_app/widgets/groups/input_qpi.dart';
import 'package:admu_student_app/widgets/groups/input_units.dart';
import 'package:admu_student_app/widgets/groups/input_year.dart';

class YearAddQPI extends StatelessWidget {
  final TextEditingController yearController;
  final TextEditingController qpiController;
  final TextEditingController unitsController;

  YearAddQPI({
    @required this.yearController,
    @required this.qpiController,
    @required this.unitsController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text Field at the Left
          Expanded(child: InputYearGroup(yearController)),
          SizedBox(width: 20),
          // Text at the Right
          Expanded(child: InputQPIGroup('Yearly', qpiController)),
          // testing for units
          SizedBox(width: 20),
          Expanded(child: InputUnitsGroup(unitsController)),
        ],
      ),
    );
  }
}
