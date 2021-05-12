import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final Color borderColor;
  final Color cardColor;
  final Color tagColor;
  final Color gradeColor;
  final String courseTitle;
  final double units;
  final String grade;
  final VoidCallback onPressed;

  CourseCard(this.borderColor, this.cardColor, this.tagColor, this.gradeColor,
      this.courseTitle, this.units, this.grade, this.onPressed);

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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$courseTitle',
                                style: Theme.of(context).textTheme.headline5),
                            Container(
                              width: 56,
                              height: 19,
                              decoration: BoxDecoration(
                                  color: tagColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3.55))),
                              child: Center(
                                child: Text(
                                  '$units Units',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(color: borderColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Text('$grade',
                              style: Theme.of(context).textTheme.headline4.copyWith(color: gradeColor))),
                      Expanded(
                          flex: 2,
                          child: IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {
                                onPressed();
                              }))
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
