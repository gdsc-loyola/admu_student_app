import 'package:intl/intl.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/widgets/home/pomodoro.dart';

class HomePage extends StatefulWidget {
  final String today = DateFormat.yMMMMEEEEd('en_US').format(DateTime.now());
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: new BoxDecoration(
                    color: AppColors.PRIMARY_LIGHT,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hey, Lorem!',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.left,
                  ),

                  Text(
                    'Ready to start your day?',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.GRAY_DARK[1]),
                  ),
                ],
              )
            ],
          ),
        ),

        Text(widget.today,
        style: Theme.of(context).textTheme.headline5,
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: PhysicalModel(
            color: Colors.black,
            elevation: 8,
            child: Container(
              height: MediaQuery.of(context).size.height/2.9,
              width: MediaQuery.of(context).size.width-32,
              color: Colors.white,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('For Today: ' + '##',
                      style: Theme.of(context).textTheme.headline6.copyWith(color: AppColors.PRIMARY_MAIN),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(16, 26, 16, 0),
          child: Pomodoro(),
        ),
      ],
    );
  }
}
