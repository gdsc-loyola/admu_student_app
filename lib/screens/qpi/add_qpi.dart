import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/add_qpi_notifier.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:admu_student_app/models/course.dart';
import 'package:admu_student_app/widgets/input_field.dart';
import 'package:admu_student_app/widgets/buttons.dart';
import 'package:admu_student_app/widgets/select_color.dart';

class AddQPIPage extends StatelessWidget {
  final int yearNum;
  final int semNum;
  final Course course;

  final int units;

  AddQPIPage({
    this.yearNum,
    this.semNum,
    this.course,
    this.units,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddQPINotifier(),
      child: _AddQPI(
        yearNum: yearNum,
        semNum: semNum,
        course: course,
        units: units,
      ),
    );
  }
}

class _AddQPI extends StatefulWidget {
  final int yearNum;
  final int semNum;
  final Course course;

  final int units;

  _AddQPI({
    this.yearNum,
    this.semNum,
    this.course,
    this.units,
  });

  @override
  _AddQPIState createState() => _AddQPIState();
}

class _AddQPIState extends State<_AddQPI> {
  bool _isEditing;

  TextEditingController _yearController = TextEditingController();
  TextEditingController _qpiController = TextEditingController();
  TextEditingController _unitsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.yearNum != null ||
        widget.semNum != null ||
        widget.course != null) {
      _isEditing = true;
    } else
      _isEditing = false;

    if (widget.yearNum != null) _yearController.text = '${widget.yearNum}';
    // if (widget.semNum != null) _sem = widget.semNum;

    if (widget.units != null) _unitsController.text = '${widget.units}';
  }

  bool yearSelected = true;
  bool semesterSelected = false;
  bool courseSelected = false;
  String title = 'Year';

  void _onSave(int semNum, int gradeVal) {
    // use values from provider
    print('year: ${_yearController.text}');
    print('sem: $semNum');
    print('qpi: ${_qpiController.text}');
    print('units: ${_unitsController.text}');
  }

  @override
  Widget build(BuildContext context) {
    int sem = Provider.of<AddQPINotifier>(context, listen: false).semNum;
    int gradeVal = Provider.of<AddQPINotifier>(context, listen: false).gradeVal;

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
                      '${_isEditing ? 'Edit' : 'Add'} $title QPI',
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
                  yearSelected = true;
                  semesterSelected = false;
                  courseSelected = false;

                  title = 'Year';
                });
              }, () {
                // Item 2 Clicked
                setState(() {
                  yearSelected = false;
                  semesterSelected = true;
                  courseSelected = false;

                  title = 'Semester';
                });
              }, () {
                // Item 3 Clicked
                setState(() {
                  yearSelected = false;
                  semesterSelected = false;
                  courseSelected = true;

                  title = 'Course';
                });
              }),
              SizedBox(
                height: 24,
              ),
              yearSelected
                  ? YearAddQPI(
                      yearController: _yearController,
                      qpiController: _qpiController,
                      unitsController: _unitsController,
                    )
                  : SizedBox(),
              semesterSelected
                  ? SemesterAddQPI(
                      yearController: _yearController,
                      qpiController: _qpiController,
                      unitsController: _unitsController,
                    )
                  : SizedBox(),
              courseSelected
                  ? CourseAddQPI(
                      yearController: _yearController,
                      unitsController: _unitsController,
                    )
                  : SizedBox(),
              Spacer(),
              LongButton('Delete', Colors.orange, Colors.white, () {
                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }
}

class YearAddQPI extends StatelessWidget {
  final TextEditingController yearController;
  final TextEditingController qpiController;
  final TextEditingController unitsController;

  YearAddQPI({
    @required this.yearController,
    @required this.qpiController,
    @required this.unitsController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Year Level',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: AppColors.GRAY_LIGHT[2]),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: 181,
                child: InputField(
                  controller: yearController,
                  isMultiLined: false,
                  length: null,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Yearly QPI',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: AppColors.GRAY_LIGHT[2]),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: 181,
                child: InputField(
                  controller: qpiController,
                  isMultiLined: false,
                  length: null,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SemesterAddQPI extends StatelessWidget {
  final TextEditingController yearController;
  final TextEditingController qpiController;
  final TextEditingController unitsController;

  SemesterAddQPI({
    @required this.yearController,
    @required this.qpiController,
    @required this.unitsController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // Main Column for Widgets
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row for Text Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text Field at the Left
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Year Level',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.GRAY_LIGHT[2]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 181,
                    child: InputField(
                      controller: yearController,
                      isMultiLined: false,
                      length: null,
                    ),
                  )
                ],
              ),
              // Text Field at the Right
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Semestral QPI',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.GRAY_LIGHT[2]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 181,
                    child: InputField(
                      controller: qpiController,
                      isMultiLined: false,
                      length: null,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Semester',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: AppColors.GRAY_LIGHT[2]),
          ),
          SizedBox(
            height: 8,
          ),
          SemSelect(),
        ],
      ),
    );
  }
}

class CourseAddQPI extends StatelessWidget {
  final TextEditingController yearController;
  final TextEditingController unitsController;

  CourseAddQPI({
    @required this.yearController,
    @required this.unitsController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // Main Column for Widgets
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row for Text Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text Field at the Left
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Year Level',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.GRAY_LIGHT[2]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 181,
                    child: InputField(
                      controller: yearController,
                      isMultiLined: false,
                      length: null,
                    ),
                  )
                ],
              ),
              // DropDown at the Right
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Letter Grade',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.GRAY_LIGHT[2]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  DropDown()
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          // 2nd row of widgets
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Semester',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.GRAY_LIGHT[2]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SemSelect(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Units',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.GRAY_LIGHT[2]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 181,
                    child: InputField(
                      controller: unitsController,
                      isMultiLined: false,
                      length: null,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          // 3rd Row of Widgets
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Color Code',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: AppColors.GRAY_LIGHT[2]),
              ),
              SizedBox(
                height: 10,
              ),
              SelectColor()
            ],
          )
        ],
      ),
    );
  }
}
