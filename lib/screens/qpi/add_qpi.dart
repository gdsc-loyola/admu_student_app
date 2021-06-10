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
import 'package:admu_student_app/widgets/modals/alert.dart';
import 'package:admu_student_app/widgets/modals/custom_snack_bar.dart';
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
    this.yearNum,
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
  bool _shouldPop = false;

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
        color: _courseColor,
        onColorChange: _onColorChange,
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

  @override
  void dispose() {
    _yearCtrl.dispose();
    _qpiCtrl.dispose();
    _unitsCtrl.dispose();
    _codeCtrl.dispose();

    super.dispose();
  }

  void _onColorChange(Color color) {
    setState(() {
      _courseColor = color;
    });
  }

  void _onSemChange(int val) {
    setState(() {
      _semNum = val;
    });
  }

  void _onGradeChange(int val) {
    setState(() {
      _gradeVal = val;
    });
  }

  Future<bool> _onBack() async {
    if (_shouldPop) return true;

    bool willPop = false;

    await AlertModal.showAlert(context,
        header: 'Discard changes?', acceptText: 'Discard', onAccept: () {
      Navigator.of(context).pop();
      willPop = true;
    });

    return willPop;
  }

  void _onSave() {
    // no error handling
    int yearNum = int.parse(_yearCtrl.text);
    int units = int.parse(_unitsCtrl.text);
    String code = _codeCtrl.text;

    if (selected == 0) {
      double qpi = double.parse(_qpiCtrl.text);
      if (widget.isEditing) {
        Provider.of<AcademicRecords>(context, listen: false).editYearlyQPI(
          widget.year,
          yearNum,
          units,
          qpi,
        );

        CustomSnackBar.showSnackBar(context, 'Year QPI edited!');
      } else {
        Provider.of<AcademicRecords>(context, listen: false).addYearlyQPI(
          yearNum,
          units,
          qpi,
        );

        CustomSnackBar.showSnackBar(context, 'Year QPI added!');
      }
    } else if (selected == 1) {
      double qpi = double.parse(_qpiCtrl.text);
      if (widget.isEditing) {
        Provider.of<AcademicRecords>(context, listen: false).editSemestralQPI(
          widget.yearNum,
          widget.semester,
          yearNum,
          _semNum,
          units,
          qpi,
        );

        CustomSnackBar.showSnackBar(context, 'Semester QPI edited!');
      } else {
        Provider.of<AcademicRecords>(context, listen: false).addSemestralQPI(
          yearNum,
          _semNum,
          units,
          qpi,
        );

        CustomSnackBar.showSnackBar(context, 'Semester QPI added!');
      }
    } else if (selected == 2) {
      if (widget.isEditing) {
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

        CustomSnackBar.showSnackBar(context, 'Class QPI edited!');
      } else {
        Provider.of<AcademicRecords>(context, listen: false).addCourse(
          yearNum,
          _semNum,
          code,
          _courseColor.value,
          units,
          GRADES[_gradeVal - 1],
          true, // no handling for non-included
        );

        CustomSnackBar.showSnackBar(context, 'Class QPI added!');
      }
    }

    _shouldPop = true;
    Navigator.of(context).pop();
  }

  void _onDelete() async {
    bool toDelete = false;

    await AlertModal.showAlert(
      context,
      header: 'Delete QPI',
      onAccept: () {
        toDelete = true;
      },
    );

    if (!toDelete) return;

    if (selected == 0) {
      Provider.of<AcademicRecords>(context, listen: false)
          .deleteYearlyQPI(widget.yearNum);
      CustomSnackBar.showSnackBar(context, 'Year QPI deleted!');
    } else if (selected == 1) {
      Provider.of<AcademicRecords>(context, listen: false)
          .deleteSemestralQPI(widget.yearNum, widget.semester.semNum);
      CustomSnackBar.showSnackBar(context, 'Semester QPI deleted!');
    } else if (selected == 2) {
      Provider.of<AcademicRecords>(context, listen: false).deleteCourse(
          widget.yearNum, widget.semNum, widget.course.courseCode);
      CustomSnackBar.showSnackBar(context, 'Class QPI deleted!');
    }

    _shouldPop = true;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.close_rounded),
          onPressed: _onBack,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: TextButton(
              onPressed: _onSave,
              child: Text('Done',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: AppColors.GRAY_LIGHT[2])),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.PRIMARY_MAIN,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0), // bot 96
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${widget.isEditing ? 'Edit' : 'Add'} ${titles[selected]} QPI',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: AppColors.GRAY_LIGHT[2]),
            ),
            SizedBox(height: 40),
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

            screens[selected], // tab, replace with pageview?

            SizedBox(height: 48), // padding
            if (widget.isEditing)
              CustomButton(
                ButtonSize.medium,
                'Delete ${titles[selected]} QPI',
                AppColors.SECONDARY_MAIN,
                AppColors.GRAY_LIGHT[2],
                _onDelete,
              ),
          ],
        ),
      ),
    );

    return WillPopScope(
      onWillPop: _onBack,
      child: scaffold,
    );
  }
}
