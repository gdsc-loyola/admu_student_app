import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';

import 'package:admu_student_app/models/academic_records.dart';
import 'package:admu_student_app/models/course.dart';
import 'package:admu_student_app/screens/qpi/add_qpi.dart';
import 'package:admu_student_app/screens/qpi/qpi_page.dart';
import 'package:admu_student_app/widgets/qpi/course_widget.dart';
import 'package:admu_student_app/widgets/qpi/qpi_view.dart';

class SemesterPage extends StatefulWidget {
  final int yearNum;
  final int semNum;

  SemesterPage({@required this.yearNum, @required this.semNum});

  @override
  _SemesterPageState createState() => _SemesterPageState();
}

class _SemesterPageState extends State<SemesterPage> {
  bool _isEditing = false;
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    List<Course> courses = Provider.of<AcademicRecords>(context, listen: false)
        .getCourses(widget.yearNum, widget.semNum);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
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
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: AppColors.GRAY_LIGHT[2]),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 48.0, 24.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // semester and edit button
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${Provider.of<AcademicRecords>(context, listen: false).getSemester(widget.yearNum, widget.semNum).semString}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: AppColors.GRAY_DARK[0]),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => AddQPIPage()),
                    );
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: AppColors.GRAY_DARK[2],
                  ),
                  iconSize: 36,
                ),
              ],
            ),
            SizedBox(height: 24.0),
            // semester qpi
            QPIView(
                value: Provider.of<AcademicRecords>(context, listen: false)
                    .getSemestralQPI(widget.yearNum, widget.semNum)),
            SizedBox(height: 48.0),
            // classes, select, and add course
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Classes',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: AppColors.GRAY_DARK[0]),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isEditing = !_isEditing;
                      _selected = 0;
                    });
                  },
                  child: Container(
                    width: 72,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.PRIMARY_ALT.withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Center(
                      child: Text(_isEditing ? 'Cancel' : 'Select',
                          style: Theme.of(context).textTheme.caption.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.PRIMARY_MAIN)),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.add_rounded),
                  iconSize: 36,
                  color: AppColors.GRAY_DARK[2],
                  onPressed: () {
                    // add course
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => AddQPIPage(
                                yearNum: widget.yearNum,
                                semNum: widget.semNum,
                                selected: 2,
                              )),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            // courses
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: courses.length,
              itemBuilder: (_, index) => Container(
                margin: EdgeInsets.only(bottom: 16),
                child: CourseCard(
                    yearNum: widget.yearNum,
                    semNum: widget.semNum,
                    course: courses[index],
                    isEditing: _isEditing,
                    onSelect: () {
                      _selected++;
                    }),
              ),
            ),
            _isEditing ? Text('$_selected') : Container(), // todo
          ],
        ),
      ),
      floatingActionButton: _isEditing
          ? FloatingActionButton(
              onPressed: () {
                // delete selected
                _isEditing = false;
              },
              child: Icon(
                Icons.delete_outline_rounded,
                size: 36,
                color: AppColors.GRAY_LIGHT[2],
              ),
            )
          : Container(),
    );
  }
}
