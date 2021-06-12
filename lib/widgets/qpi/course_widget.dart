import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/course.dart';
import 'package:admu_student_app/screens/qpi/add_qpi.dart';
import 'package:admu_student_app/widgets/circular_check_mark.dart';

class CourseCard extends StatelessWidget {
  final int yearNum;
  final int semNum;

  final Course course;
  final bool isEditing;
  final bool selected;
  final VoidCallback onSelect;

  CourseCard({
    @required this.yearNum,
    @required this.semNum,
    @required this.course,
    this.isEditing = false,
    this.selected = false,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      decoration: BoxDecoration(
        color: AppColors.GRAY_LIGHT[2],
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [AppEffects.SHADOW],
      ),
      height: 72,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // line
          Container(
            margin: EdgeInsets.only(right: 22),
            decoration: BoxDecoration(
              color: course.color,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            width: 10,
            height: 72, // from 64
          ),
          // text and units
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${course.courseCode}',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: AppColors.GRAY)),
              Container(
                width: 64,
                height: 19,
                decoration: BoxDecoration(
                    color: course.color.withOpacity(0.25),
                    borderRadius:
                        BorderRadius.all(Radius.circular(4))), // original 3.55
                child: Center(
                  child: Text(
                    '${course.units} Units',
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: course.color, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          // letter grade
          Container(
            width: 48,
            child: Text(
              '${course.letterGrade}',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: course.color),
            ),
          ),
          // button edit
          IconButton(
            icon: Icon(Icons.more_vert),
            iconSize: 36,
            color: AppColors.GRAY_LIGHT[0],
            onPressed: () {
              // edit course
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => AddQPIPage(
                        yearNum: yearNum,
                        semNum: semNum,
                        course: course,
                        isEditing: true,
                        selected: 2,
                      )));
            },
          ),
        ],
      ),
    );

    if (isEditing)
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularCheckMark(isDone: selected, onTap: onSelect),
            SizedBox(width: 10),
            Expanded(child: card),
          ],
        ),
      );
    else
      return card;
  }
}
