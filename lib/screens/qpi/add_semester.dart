import 'package:flutter/material.dart';

import 'package:admu_student_app/widgets/groups/input_group.dart';
import 'package:admu_student_app/widgets/groups/select_semester.dart';

class SemesterAddQPI extends StatelessWidget {
  final TextEditingController yearController;
  final TextEditingController qpiController;
  final TextEditingController unitsController;

  final int selected;
  final Function(int) onValueChange;

  SemesterAddQPI({
    @required this.yearController,
    @required this.qpiController,
    @required this.unitsController,
    this.selected,
    this.onValueChange,
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
              Expanded(
                child: InputGroup(
                  'Year Level',
                  yearController,
                  hint: '1',
                  length: 1,
                ),
              ),
              SizedBox(width: 20),
              // Text at the Right
              Expanded(
                child: InputGroup(
                  'Semestral QPI',
                  qpiController,
                  hint: '4.0',
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
                  selected: selected,
                  onValueChange: onValueChange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
