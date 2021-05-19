import 'package:flutter/material.dart';

import 'package:admu_student_app/screens/enlistment/enlistment_classes.dart';
import 'package:admu_student_app/widgets/qpi/course_widget.dart';
import 'package:admu_student_app/constants/app_colors.dart';

class EnlistmentPage extends StatefulWidget {
  @override
  _EnlistmentPageState createState() => _EnlistmentPageState();
}

class _EnlistmentPageState extends State<EnlistmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 48, 16, 29),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Enlistment Preparer',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: AppColors.GRAY_DARK[0])),
                    CircleAvatar(
                    radius: 13.5,
                    backgroundColor: AppColors.PRIMARY_MAIN,
                    child: Center(
                      child: Text(
                        '?',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  )
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 35, 0, 24),
                  child: Row(
                    children: [
                      Text(
                        'Classes',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: AppColors.GRAY_DARK[0]),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.PRIMARY_LIGHT.withOpacity(0.2),
                            borderRadius: BorderRadius.all(Radius.circular(100))),
                        child: InkWell(
                          onTap: () {},
                          child: Ink(
                            child: Container(
                              height: 24,
                              width: 72,
                              child: Center(
                                child: Text(
                                  'Select',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(
                                          fontSize: 14,
                                          color: AppColors.PRIMARY_MAIN),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(icon: Icon(Icons.add), onPressed: () {})
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CourseCard(Colors.green, Colors.white, Colors.green[100],
                        Colors.green, 'HISTO12', 3, 'A', () {}),
                    CourseCard(Colors.green, Colors.white, Colors.green[100],
                        Colors.green, 'HISTO12', 3, 'A', () {}),
                  ],
                ),
                Container(
                  height: 64,
                  width: 224,
                  decoration: BoxDecoration(
                    color: AppColors.SECONDARY_MAIN.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(4))
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => EnlistmentClassesPage()),
                      );
                    },
                    child: Text('Create Schedule', style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white, fontSize: 20),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
