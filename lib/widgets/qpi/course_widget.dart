import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final Color borderColor;
  final Color cardColor;
  final Color gradeColor;
  final String courseTitle;
  final String grade;
  final VoidCallback onPressed;

  CourseCard(this.borderColor, this.cardColor, this.gradeColor,
      this.courseTitle, this.grade, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 64,
      child: Expanded(
        child: Card(
          color: cardColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: InkWell(
            onTap: () {
              print('card was pressed');
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
                          color: borderColor,
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
                            style: Theme.of(context)
                            .textTheme
                            .headline5
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
                              icon: Icon(Icons.more_vert), onPressed: () {onPressed();}))
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
