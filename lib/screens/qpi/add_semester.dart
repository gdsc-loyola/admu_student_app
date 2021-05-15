import 'package:flutter/material.dart';

import 'package:admu_student_app/widgets/groups/input_qpi.dart';
import 'package:admu_student_app/widgets/groups/input_units.dart';
import 'package:admu_student_app/widgets/groups/input_year.dart';
import 'package:admu_student_app/widgets/groups/select_semester.dart';

class SemesterAddQPI extends StatelessWidget {
  final TextEditingController yearController;
  final TextEditingController qpiController;
  final TextEditingController unitsController;

  SemesterAddQPI({
    @required this.yearController,
    @required this.qpiController,
    @required this.unitsController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // Main Column for Widgets
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row for Text Fields
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text Field at the Left
              Expanded(child: InputYearGroup(yearController)),
              SizedBox(width: 20),
              // Text at the Right
              Expanded(child: InputQPIGroup('Semestral', qpiController)),
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
        ],
      ),
    );
  }
}
