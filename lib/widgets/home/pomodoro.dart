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
      height: MediaQuery.of(context).size.height/8.615,
      alignment: Alignment.center,
      child: ListTile(
        leading: Image.asset("tomato.png"),
        title: Text("Pomodoro Timer",
          style: Theme.of(context).textTheme.headline6.copyWith(color: AppColors.SECONDARY_MAIN),
        ),
        subtitle: Text("Press to Begin",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        horizontalTitleGap: 23.28,
        contentPadding: EdgeInsets.only(left: 37.04, right: 89.94),
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
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

    );
  }
}
