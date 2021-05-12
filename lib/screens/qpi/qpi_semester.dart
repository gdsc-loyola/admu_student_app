import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';

import 'package:admu_student_app/models/academic_records.dart';
import 'package:admu_student_app/models/course.dart';
import 'package:admu_student_app/screens/qpi/ask_type.dart';
import 'package:admu_student_app/screens/qpi/qpi_page.dart';
import 'package:admu_student_app/widgets/qpi/qpi_view.dart';

class SemesterPage extends StatefulWidget {
  final int yearNum;
  final int semNum;


  SemesterPage({@required this.yearNum, @required this.semNum,});

  @override
  _SemesterPageState createState() => _SemesterPageState();
}

class _SemesterPageState extends State<SemesterPage> {

  @override
  Widget build(BuildContext context) {

    List<Course> _c = Provider.of<AcademicRecords>(context, listen: false).getCourses(widget.yearNum, widget.semNum);

    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => QPIPage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.white,
        ),
        title: Text(
          'Year ${widget.yearNum.toString()}',
          style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: (){},
            child: Text('Edit'),
            style: TextButton.styleFrom(primary: Colors.white),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Semester ${widget.semNum.toString()}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: AppColors.GRAY_DARK[0],
                        ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          // builder: (_) => AddCourseQPIPage(isEditing: false)),
                            builder: (_) => AskQPITypePage()),
                      );
                    },
                  icon: Icon(
                    Icons.add_rounded,
                    color: AppColors.GRAY_DARK[2] ,
                  ),
                  iconSize: 36,
                ),

              ],
            ),

            SizedBox(height: 24.0),

            QPIView(value: Provider.of<AcademicRecords>(context, listen: false).getSemestralQPI(widget.yearNum, widget.semNum)),

            SizedBox(height: 48.0),

            Text(
              'Classes',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: AppColors.GRAY_DARK[0]),
            ),
          ],
        ),
      ),
    );
  }
}
