import 'dart:math';

import 'package:admu_student_app/widgets/help_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/academic_records.dart';
import 'package:admu_student_app/models/year.dart';
// import 'package:admu_student_app/screens/qpi/qpi_semester.dart'; // commented and will edit
import 'package:admu_student_app/widgets/qpi/qpi_view.dart';
import 'package:admu_student_app/widgets/qpi/year_drop_down.dart';

class QPIPage extends StatefulWidget {
  @override
  _QPIPageState createState() => _QPIPageState();
}

class _QPIPageState extends State<QPIPage> {
  @override
  Widget build(BuildContext context) {
    List<Year> years = Provider.of<AcademicRecords>(context).years;

    return Column(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center, //To center the icon and title
                children: [
                  Expanded(
                    child: Text(
                      'Cumulative QPI',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: AppColors.GRAY_DARK[0]),
                    ),
                  ),

                  HelpButton(
                    isInverted: false,
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              QPIView(value: Provider.of<AcademicRecords>(context).cumulativeQPI),
              SizedBox(height: 48.0),
              Text(
                'QPI Overview',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: AppColors.GRAY_DARK[0]),
              ),
              SizedBox(height: 16.0),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: years.length,
                itemBuilder: (_, index) {
                  Year yr = years[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: YearDropDown(yearNum: yr.yearNum),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  int yearNum = Random().nextInt(5) + 1;
                  int semNum = Random().nextInt(3);
                  double qpi = Random().nextDouble() * 4.0;

                  Provider.of<AcademicRecords>(context, listen: false)
                      .addCourse(yearNum, semNum, 'TEST 123', 0, 3, qpi, true);
                },
                child: Text('add new course'),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<AcademicRecords>(context, listen: false)
                      .deleteAllData();
                },
                child: Text('delete rows'),
              ),
            ],
          ),
        ),


        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
              Text(
                'Inspired by:',
                style: Theme.of(context).textTheme.caption.copyWith(color: AppColors.GRAY_DARK[1]),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: Image.asset(
                      'apple.png',
                      height: 36,
                      width: 36,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      "Computer Society of the Ateneo's QPI Calculator",
                      style: Theme.of(context).textTheme.caption.copyWith(color: AppColors.GRAY_DARK[1]),
                    ),
                  ),
                ],
              ),
          ],
        ),
            )),

      ],
    );
  }
}
