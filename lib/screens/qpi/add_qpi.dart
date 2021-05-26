import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/academic_records.dart';
import 'package:admu_student_app/models/course.dart';
import 'package:admu_student_app/models/semester.dart';
import 'package:admu_student_app/models/year.dart';
import 'package:admu_student_app/screens/qpi/add_course.dart';
import 'package:admu_student_app/screens/qpi/add_semester.dart';
import 'package:admu_student_app/screens/qpi/add_year.dart';
import 'package:admu_student_app/widgets/button_row.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class AddQPIPage extends StatefulWidget {
  final int yearNum;
  final int semNum;

  final Year year;
  final Semester semester;
  final Course course;

  final int units;

  final bool isEditing;
  final int selected;

  AddQPIPage({
    this.yearNum = 1,
    this.semNum = 1,
    this.year,
    this.semester,
    this.course,
    this.units,
    this.isEditing = false,
    this.selected = 0,
  });

  @override
  _AddQPIPageState createState() => _AddQPIPageState();
}

class _AddQPIPageState extends State<AddQPIPage> {
  TextEditingController _yearCtrl = TextEditingController();
  TextEditingController _qpiCtrl = TextEditingController();
  TextEditingController _unitsCtrl = TextEditingController();
  TextEditingController _codeCtrl = TextEditingController();

  int _semNum = 1;
  Color _courseColor;
  int _gradeVal = 1;

  int selected = 0;
  final List<String> titles = ['Year', 'Semester', 'Course'];
  List<Widget> screens = [];

  final List<double> GRADES = [4.0, 3.5, 3.0, 2.5, 2.0, 1.0, 0.0];

  @override
  void initState() {
    super.initState();

    if (widget.yearNum != null) {
      _yearCtrl.text = '${widget.yearNum}';
    }
    if (widget.year != null) {
      _unitsCtrl.text = '${widget.year.units}';
    }
    if (widget.semNum != null) {
      _semNum = widget.semNum;
    }
    if (widget.semester != null) {
      _unitsCtrl.text = '${widget.semester.units}';
      _semNum = widget.semester.semNum;
    }
    if (widget.course != null) {
      _unitsCtrl.text = '${widget.course.units}';
      _codeCtrl.text = widget.course.courseCode;

      _courseColor = widget.course.color;

      for (int i = 0; i < GRADES.length; i++) {
        if (GRADES[i] == widget.course.qpi) {
          _gradeVal = i + 1;
          break;
        }
      }
    }
    if (widget.isEditing && widget.selected == 0) {
      _yearCtrl.text = '${widget.year.yearNum}';
      _qpiCtrl.text = '${widget.year.yearlyQPI}';
    } else if (widget.isEditing && widget.selected == 1) {
      _qpiCtrl.text = '${widget.semester.semestralQPI}';
    }

    screens = [
      YearAddQPI(
        yearController: _yearCtrl,
        unitsController: _unitsCtrl,
        qpiController: _qpiCtrl,
      ),
      SemesterAddQPI(
        yearController: _yearCtrl,
        unitsController: _unitsCtrl,
        qpiController: _qpiCtrl,
        selected: _semNum,
        onValueChange: _onSemChange,
      ),
      CourseAddQPI(
        yearController: _yearCtrl,
        unitsController: _unitsCtrl,
        codeController: _codeCtrl,
        color: _courseColor,
        onColorChange: _onColorChange,
        sem: _semNum,
        onSemChange: _onSemChange,
        gradeVal: _gradeVal,
        onGradeChange: _onGradeChange,
      ),
    ];

    selected = widget.selected > 2 ? 0 : widget.selected;
  }

  void _onColorChange(Color color) {
    setState(() {
      _courseColor = color;
    });
    print('color change ${color.value}');
  }

  void _onSemChange(int val) {
    setState(() {
      _semNum = val;
    });
    print('sem change $val');
  }

  void _onGradeChange(int val) {
    setState(() {
      _gradeVal = val;
    });
    print('grade change $val');
  }

  void _onSave() async {
    // no error handling
    int yearNum = int.parse(_yearCtrl.text);
    int units = int.parse(_unitsCtrl.text);
    String code = _codeCtrl.text;

    if (selected == 0) {
      double qpi = double.parse(_qpiCtrl.text);
      if (widget.isEditing)
        Provider.of<AcademicRecords>(context, listen: false).editYearlyQPI(
          widget.year,
          yearNum,
          units,
          qpi,
        );
      else
        Provider.of<AcademicRecords>(context, listen: false).addYearlyQPI(
          yearNum,
          units,
          qpi,
        );
    } else if (selected == 1) {
      double qpi = double.parse(_qpiCtrl.text);
      if (widget.isEditing)
        Provider.of<AcademicRecords>(context, listen: false).editSemestralQPI(
          widget.yearNum,
          widget.semester,
          yearNum,
          _semNum,
          units,
          qpi,
        );
      else
        Provider.of<AcademicRecords>(context, listen: false).addSemestralQPI(
          yearNum,
          _semNum,
          units,
          qpi,
        );
    } else if (selected == 2) {
      if (widget.isEditing)
        Provider.of<AcademicRecords>(context, listen: false).editCourse(
          widget.yearNum,
          widget.semNum,
          widget.course,
          yearNum,
          _semNum,
          code,
          _courseColor.value,
          units,
          GRADES[_gradeVal - 1],
          true, // no handling
        );
      else
        Provider.of<AcademicRecords>(context, listen: false).addCourse(
          yearNum,
          _semNum,
          code,
          _courseColor.value,
          units,
          GRADES[_gradeVal - 1],
          true, // no handling for non-included
        );
    }

    Navigator.of(context).pop();
  }

  void _onDelete() async {
    if (selected == 0)
      Provider.of<AcademicRecords>(context, listen: false)
          .deleteYearlyQPI(widget.yearNum);
    else if (selected == 1)
      Provider.of<AcademicRecords>(context, listen: false)
          .deleteSemestralQPI(widget.yearNum, widget.semester.semNum);
    else if (selected == 2)
      Provider.of<AcademicRecords>(context, listen: false).deleteCourse(
          widget.yearNum, widget.semNum, widget.course.courseCode);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: TextButton(
              onPressed: _onSave,
              child: Text('Done',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: AppColors.GRAY_LIGHT[2])),
            ),
          ),
        ],
        title: IconButton(
            icon: Icon(Icons.close_rounded),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
      ),
      backgroundColor: AppColors.PRIMARY_MAIN,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 48.0), // bot 96
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Row(
                children: [
                  Text(
                    '${widget.isEditing ? 'Edit' : 'Add'} ${titles[selected]} QPI',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: AppColors.GRAY_LIGHT[2]),
                  )
                ],
              ),
            ),
            ButtonRow('Year', 'Semester', 'Course', () {
              // Item 1 Clicked
              setState(() {
                selected = 0;
              });
            }, () {
              // Item 2 Clicked
              setState(() {
                selected = 1;
              });
            }, () {
              // Item 3 Clicked
              setState(() {
                selected = 2;
              });
            }, selected, widget.isEditing),
            SizedBox(height: 24),
            screens[selected],
            // Spacer(),
            SizedBox(height: 96),
            widget.isEditing
                ? LongButton('Delete', Colors.orange, Colors.white, _onDelete)
                : Container(),
          ],
        ),
      ),
    );
  }
}
