import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/widgets/schedule/schedule_timetable.dart';
import 'package:admu_student_app/widgets/input_field.dart';
import 'package:admu_student_app/widgets/select_color.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<bool> colorSelected = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    /*return Container(
      color: AppColors.PRIMARY_MAIN,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 55,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(9)),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: InputField(
                  isMultiLined: false,
                  length: 8,
                ),
              ),
              Padding(padding: EdgeInsets.all(8)),
            ],
          ),
          Row(
            children: [
              Container(
                height: 55,
              ),
            ],
          ),
          SelectColor(),
          Row(
            children: [
              Container(
                height: 55,
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: InputField(
              isMultiLined: false,
              length: null,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            child: InputField(
              isMultiLined: true,
              length: null,
            ),
          ),
        ],
      ),
    );*/

    return Container(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 48),
      child: Column(
        children: [
          Expanded(
            // child: Container(color: Colors.green),
            child: ScheduleTimetable(yearNum: 1, semNum: 2, qtrNum: 4),
          ),
        ],
      ),
    );
  }
}
