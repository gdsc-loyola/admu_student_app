import 'package:admu_student_app/main.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';

import 'package:admu_student_app/screens/home/pomodoro_page.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width-32,
      height: 104,
      child: ListTile(
        leading: Image.asset("apple.png"),
        title: Text("Pomodoro Timer",
          style: Theme.of(context).textTheme.headline6.copyWith(color: AppColors.SECONDARY_MAIN),
        ),
        subtitle: Text("Press to Begin",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        contentPadding: EdgeInsets.fromLTRB(37.04, 21, 89.94, 24),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => PomodoroPage()),
          );
        },
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.SECONDARY_MAIN,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),

    );
  }
}
