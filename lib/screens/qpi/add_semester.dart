import 'package:flutter/material.dart';

import 'package:admu_student_app/widgets/groups/input_group.dart';
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
        children: [
          // Row for Text Fields
          Row(
            children: [
              // Text Field at the Left
              Expanded(child: InputGroup('Year Level', yearController)),
              SizedBox(width: 20),
              // Text at the Right
              Expanded(child: InputGroup('Semestral QPI', qpiController)),
            ],
          ),
          SizedBox(height: 16),
          // 2nd row of widgets
          Row(
            children: [
              Expanded(child: SelectSemesterGroup()),
              SizedBox(width: 20),
              Expanded(child: InputGroup('Units', unitsController)),
            ],
          ),
        ],
      ),
    );
  }
}
