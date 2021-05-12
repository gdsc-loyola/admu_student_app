import 'package:admu_student_app/widgets/circular_check_mark.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/course.dart';
import 'package:admu_student_app/screens/qpi/add_qpi.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final bool isEditing;
  final VoidCallback onSelect;

  // final Color borderColor;
  // final Color cardColor;
  // final Color tagColor;
  // final Color gradeColor;
  // final String courseTitle;
  // final double units;
  // final String grade;
  // final VoidCallback onPressed;

  // CourseCard(this.borderColor, this.cardColor, this.tagColor, this.gradeColor,
  //     this.courseTitle, this.units, this.grade, this.onPressed);

  CourseCard({@required this.course, this.isEditing = false, this.onSelect});

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      decoration: BoxDecoration(
        color: AppColors.GRAY_LIGHT[1],
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
            height: 64,
          ),
          // text and units
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${course.courseCode}',
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AddQPIPage()));
            },
          ),
        ],
      ),
    );

    /*if (isEditing)
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularCheckMark(onTap: onSelect),
          SizedBox(width: 10),
          card,
        ],
      );
    else*/
      return card;

    /*return Container(
      color: Colors.transparent,
      height: 64,
      child: Expanded(
        child: Card(
          color: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: InkWell(
            onTap: () {
              print('card was pressed');
              // should be deleted
            },
            child: Ink(
              // Container for Text Row
              child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 10,
                        height: 64,
                        decoration: BoxDecoration(
                          color: course.color,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      Expanded(
                        flex: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${course.courseCode}',
                                style: Theme.of(context).textTheme.headline5),
                            Container(
                              width: 56,
                              height: 19,
                              decoration: BoxDecoration(
                                  color: course.color.withOpacity(0.1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3.55))),
                              child: Center(
                                child: Text(
                                  '${course.units} Units',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(color: course.color),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Text('${course.letterGrade}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                      color: course.color,
                                      fontWeight: FontWeight.bold))),
                      Expanded(
                          flex: 2,
                          child: IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {
                              // onPressed();
                              // should only be the one that is clickable
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => AddQPIPage()));
                            },
                          ))
                    ]),
              ),
            ),
          ),
        ),
      ),
    );*/
  }
}
