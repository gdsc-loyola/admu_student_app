import 'package:admu_student_app/main.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final Color cardColor;
  final Color gradeColor;
  final String courseTitle;
  final String grade;

  CourseCard(this.cardColor, this.gradeColor, this.courseTitle, this.grade);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 382,
      height: 64,
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: InkWell(
          onTap: () {print('card was pressed');},
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
                        color: cardColor,
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
                        child: Text(
                          '$courseTitle',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                          '$grade',
                          style: TextStyle(fontSize: 32, color: gradeColor),
                        )),
                    Expanded(
                        flex: 2,
                        child: IconButton(
                            icon: Icon(Icons.more_vert), onPressed: () {}))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
