import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/class_schedule.dart';
import 'package:admu_student_app/models/subject.dart';
import 'package:admu_student_app/widgets/groups/input_group.dart';
import 'package:admu_student_app/widgets/groups/select_color.dart';
import 'package:admu_student_app/widgets/groups/select_days.dart';
import 'package:admu_student_app/widgets/groups/select_semester.dart';
import 'package:admu_student_app/widgets/groups/select_time.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class AddClassPage extends StatefulWidget {
  final Subject subject;
  final bool inEnlistment;
  final bool isEditing;

  AddClassPage({
    this.inEnlistment = false,
    this.isEditing = false,
    this.subject,
  });

  @override
  _AddClassPageState createState() => _AddClassPageState();
}

class _AddClassPageState extends State<AddClassPage> {
  TextEditingController _codeCtrl = TextEditingController();
  TextEditingController _sectionCtrl = TextEditingController();
  TextEditingController _yearCtrl = TextEditingController();
  TextEditingController _unitCtrl = TextEditingController();
  TextEditingController _profCtrl = TextEditingController();

  int _semNum = 1;

  List<bool> _days = List.generate(6, (index) => false);
  TimeOfDay _timeStart;
  TimeOfDay _timeEnd;

  Color _color;

  @override
  void initState() {
    super.initState();
  }

  void _onSemesterChange(int val) {
    setState(() {
      _semNum = val;
    });
  }

  void _onDaysChange(List<bool> sel) {
    setState(() {
      _days = sel;
    });
  }

  void _onStartTimeChange(TimeOfDay tod) {
    setState(() {
      _timeStart = tod;
    });
  }

  void _onEndTimeChange(TimeOfDay tod) {
    setState(() {
      _timeEnd = tod;
    });
  }

  void _onColorChange(Color c) {
    setState(() {
      _color = c;
    });
  }

  void _onSave() {
    int yearNum = int.parse(_yearCtrl.text);
    int units = int.parse(_unitCtrl.text);

    if (widget.isEditing) {
      Provider.of<ClassSchedule>(context, listen: false).editSubject();
    } else {
      Provider.of<ClassSchedule>(context, listen: false).addSubject(
        _codeCtrl.text,
        _sectionCtrl.text,
        yearNum,
        units,
        _semNum,
        _color,
        _days,
        _timeStart,
        _timeEnd,
        _profCtrl.text,
      );
    }

    Navigator.of(context).pop();
  }

  void _onDelete() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_MAIN,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.close_rounded),
                onPressed: () {
                  Navigator.pop(context);
                }),
            TextButton(
              onPressed: _onSave,
              child: Text(
                'Done',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 48, 16, 48),
        child: Column(
          children: [
            // header
            Center(
              child: Text(
                '${widget.isEditing ? 'Edit' : 'Add'} Class',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white),
              ),
            ),
            SizedBox(height: 24),

            // course code and section
            Row(
              children: [
                // Text Field at the Left
                Expanded(child: InputGroup('Course Code', _codeCtrl)),
                SizedBox(width: 20),
                // Text at the Right
                Expanded(child: InputGroup('Section', _sectionCtrl)),
              ],
            ),
            SizedBox(height: 24),

            // year level and units
            Row(
              children: [
                // Text Field at the Left
                Expanded(child: InputGroup('Year Level', _yearCtrl)),
                SizedBox(width: 20),
                // Text at the Right
                Expanded(child: InputGroup('Units', _unitCtrl)),
              ],
            ),
            SizedBox(height: 24),

            // semester
            Row(
              children: [
                Expanded(
                  child: SelectSemesterGroup(
                    selected: _semNum,
                    onValueChange: _onSemesterChange,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(child: Container()),
              ],
            ),
            SizedBox(height: 24),

            // select color
            SelectColor(color: _color, onColorChange: _onColorChange),
            SizedBox(height: 24),

            // days
            SelectDaysGroup(selected: _days, onChange: _onDaysChange),
            SizedBox(height: 24),

            // start and end time
            Row(
              children: [
                // Row for Time Selectors
                Expanded(child:SelectTimeGroup(
                  'Start',
                  time: _timeStart,
                  onTimeChange: _onStartTimeChange,
                ),),
                SizedBox(width: 20),
                Expanded(child:SelectTimeGroup(
                  'End',
                  time: _timeEnd,
                  onTimeChange: _onEndTimeChange,
                ),),
              ],
            ),

            // professor in enlistment
            widget.inEnlistment
                ? Expanded(
                    child: InputGroup('Name of Professor', _profCtrl),
                  )
                : SizedBox(),

            // delete button
            widget.isEditing
                ? LongButton(
                    'Delete Class',
                    AppColors.SECONDARY_MAIN,
                    AppColors.GRAY_LIGHT[2],
                    _onDelete,
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
