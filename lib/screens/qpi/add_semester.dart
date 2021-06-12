import 'package:flutter/material.dart';

import 'package:admu_student_app/widgets/groups/input_group.dart';
import 'package:admu_student_app/widgets/groups/select_color.dart';
import 'package:admu_student_app/widgets/groups/select_semester.dart';

class SemesterAddQPI extends StatelessWidget {
  final TextEditingController yearController;
  final TextEditingController qpiController;
  final TextEditingController unitsController;

  final int selected;
  final Function(int) onValueChange;

  final Color color;
  final Function(Color) onColorChange;

  SemesterAddQPI({
    @required this.yearController,
    @required this.qpiController,
    @required this.unitsController,
    this.selected,
    this.onValueChange,
    this.color,
    this.onColorChange,
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
              // year
              Expanded(
                child: InputGroup(
                  'Year Level*',
                  yearController,
                  hint: '1',
                  length: 1,
                ),
              ),
              SizedBox(width: 20),

              // sem
              Expanded(
                child: SelectSemesterGroup(
                  label: 'Semester*',
                  selected: selected,
                  onValueChange: onValueChange,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // 2nd row of widgets
          Row(
            children: [
              // units
              Expanded(
                child: InputGroup(
                  'Units*',
                  unitsController,
                  hint: '3',
                ),
              ),
              SizedBox(width: 20),

              // qpi
              Expanded(
                child: InputGroup(
                  'Semestral QPI*',
                  qpiController,
                  hint: '4.00',
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // color
          // SelectColor(
          //   label: 'Color Code*',
          //   color: color,
          //   onColorChange: onColorChange,
          // ),
        ],
      ),
    );
  }
}
