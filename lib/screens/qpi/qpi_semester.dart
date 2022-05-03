import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';

import 'package:admu_student_app/models/_all_courses.dart';
import 'package:admu_student_app/models/_course.dart';
import 'package:admu_student_app/models/_semester.dart';
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
  List<bool> _cSelected; // = List.generate(6, (index) => false);

  @override
  void initState() {
    super.initState();
  }

  void _onDelete(BuildContext context, List<Course> courses) {
    for (int i = _cSelected.length - 1; i >= 0; i--) {
      if (_cSelected[i]) {
        Provider.of<AllCourses>(context, listen: false).deleteCourse(
            courses[i].id, widget.yearNum, widget.semNum, courses[i].code);
      }
    }

    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Course> courses = Provider.of<AllCourses>(context)
        .getCourses(widget.yearNum, widget.semNum);

    Semester sem = Provider.of<AllCourses>(context, listen: false)
        .getSemester(widget.yearNum, widget.semNum);

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
          iconSize: 32,
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
        padding: EdgeInsets.fromLTRB(16.0, 40.0, 24.0, 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // semester text
            Text(
              '${sem == null ? 'Semester' : sem.semString}',
              // overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: AppColors.GRAY_DARK[0]),
            ),
            SizedBox(height: 24.0),

            // semester qpi
            QPIView(
                value: Provider.of<AllCourses>(context, listen: false)
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
                InkWell(
                  onTap: () {
                    setState(() {
                      _isEditing = !_isEditing;
                      _selected = 0;
                      _cSelected =
                          List.generate(courses.length, (index) => false);
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
                    selected: _isEditing ? _cSelected[index] : false,
                    onSelect: () {
                      setState(() {
                        if (_cSelected[index])
                          _selected--;
                        else
                          _selected++;
                        _cSelected[index] = !_cSelected[index];
                      });
                    }),
              ),
            ),

            // editing text
            if (_isEditing)
              Align(
                alignment: Alignment.center,
                child: Text(
                  _selected > 0
                      ? (_selected > 1
                          ? '$_selected Classes Selected'
                          : '$_selected Class Selected')
                      : 'Select Classes',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: _selected > 0
                            ? AppColors.SECONDARY_MAIN
                            : AppColors.GRAY_DARK[1],
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: _isEditing
          ? FloatingActionButton(
              onPressed: () => _onDelete(context, courses),
              child: Icon(
                CupertinoIcons.delete, // incorrect icon
                size: 36,
                color: AppColors.GRAY_LIGHT[2],
              ),
              backgroundColor: AppColors.SECONDARY_MAIN,
            )
          : Container(),
    );
  }
}
