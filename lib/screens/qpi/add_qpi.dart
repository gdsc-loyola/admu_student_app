import 'package:admu_student_app/models/academic_records.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/add_qpi_notifier.dart';
import 'package:admu_student_app/models/course.dart';
import 'package:admu_student_app/models/semester.dart';
import 'package:admu_student_app/models/year.dart';
import 'package:admu_student_app/screens/qpi/add_course.dart';
import 'package:admu_student_app/screens/qpi/add_semester.dart';
import 'package:admu_student_app/screens/qpi/add_year.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class AddQPIPage extends StatelessWidget {
  final int yearNum;
  final int semNum;

  final Year year;
  final Semester semester;
  final Course course;

  final int units;

  final bool isEditing;
  // 0 = year
  // 1 = sem
  // 2 = course
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
  Widget build(BuildContext context) {
    AddQPINotifier provider;

    if (course != null)
      provider = AddQPINotifier.fromCourse(semNum, course);
    else
      provider = AddQPINotifier.fromYearSem(
          semester != null ? semester.semNum : semNum);

    return ChangeNotifierProvider(
      create: (_) => provider,
      child: _AddQPI(
        yearNum: yearNum,
        year: year,
        semester: semester,
        course: course,
        units: units,
        isEditing: isEditing,
        selected: selected,
      ),
    );
  }
}

class _AddQPI extends StatefulWidget {
  final int yearNum;

  final Year year;
  final Semester semester;
  final Course course;

  final int units;

  final bool isEditing;
  final int selected;

  _AddQPI({
    this.yearNum,
    this.year,
    this.semester,
    this.course,
    this.units,
    this.isEditing,
    this.selected,
  });

  @override
  _AddQPIState createState() => _AddQPIState();
}

class _AddQPIState extends State<_AddQPI> {
  TextEditingController _yearCtrl = TextEditingController();
  TextEditingController _qpiCtrl = TextEditingController();
  TextEditingController _unitsCtrl = TextEditingController();
  TextEditingController _codeCtrl = TextEditingController();

  int selected = 0;
  final List<String> titles = ['Year', 'Semester', 'Course'];
  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();

    if (widget.yearNum != null) {
      _yearCtrl.text = '${widget.yearNum}';
    }
    if (widget.units != null) {
      _unitsCtrl.text = '${widget.units}';
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
      ),
      CourseAddQPI(
        yearController: _yearCtrl,
        unitsController: _unitsCtrl,
        codeController: _codeCtrl,
      ),
    ];

    selected = widget.selected > 2 ? 0 : widget.selected;
  }

  void _onSave(int semNum, int gradeVal) async {
    // use values from provider
    // todo

    if (selected == 0) {
      int year = int.parse(_yearCtrl.text);
      double qpi = double.parse(_qpiCtrl.text);
      int units = 20; //double.parse(_unitsCtrl.text);

      print('year: $year');
      print('qpi: $qpi');
      print('units: $units');

      if (widget.isEditing)
        Provider.of<AcademicRecords>(context, listen: false).editYearlyQPI(
          widget.year,
          year,
          units,
          qpi,
        );
      else
        Provider.of<AcademicRecords>(context, listen: false).addYearlyQPI(
          year,
          units,
          qpi,
        );
    } else if (selected == 1) {
      print('year: ${_yearCtrl.text}');
      print('sem: $semNum');
      print('qpi: ${_qpiCtrl.text}');
      print('units: ${_unitsCtrl.text}');
    } else if (selected == 2) {
      print('year: ${_yearCtrl.text}');
      print('qpi: ${_qpiCtrl.text}');
      print('units: ${_unitsCtrl.text}');
      print('code: ${_codeCtrl.text}');
      // also get what color is used
    }

    Navigator.of(context).pop();
  }

  void _onDelete() async {
    if (selected == 0) {
      Provider.of<AcademicRecords>(context, listen: false)
          .deleteYearlyQPI(int.parse(_yearCtrl.text));

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    int sem = Provider.of<AddQPINotifier>(context).semNum;
    int gradeVal = Provider.of<AddQPINotifier>(context).gradeVal;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: TextButton(
              onPressed: () => _onSave(sem, gradeVal),
              child: Text('Done',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: AppColors.GRAY_LIGHT[2])),
            ),
          ),
        ],
        title: IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          color: AppColors.PRIMARY_MAIN,
          padding: EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 96.0),
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
              }, selected),
              SizedBox(height: 24),
              screens[selected],
              Spacer(),
              LongButton('Delete', Colors.orange, Colors.white, _onDelete),
            ],
          ),
        ),
      ),
    );
  }
}
