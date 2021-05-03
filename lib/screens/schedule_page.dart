import 'package:admu_student_app/widgets/expanded_text_field.dart';
import 'package:admu_student_app/widgets/half_text_field.dart';
import 'package:admu_student_app/widgets/select_color.dart';
import 'package:admu_student_app/widgets/select_semester.dart';
import 'package:admu_student_app/widgets/whole_text_field.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/main.dart';



class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<bool> colorSelected = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PrimaryColor,

      child: Column(
        children: [

          Row(
            children: [
              Container(height: 55,),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(padding: EdgeInsets.all(9)),

              HalfTextField(),

              Expanded( child: Container(),),

              SelectSemester(),

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
              Container(height: 55,),
            ],
          ),

          WholeTextField(),

          ExpandedTextField(),

        ],
      ),
    );
  }
}