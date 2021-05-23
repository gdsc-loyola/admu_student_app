import 'package:flutter/material.dart';

import 'package:admu_student_app/widgets/groups/input_group.dart';
import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/widgets/groups/select_semester.dart';
import 'package:admu_student_app/widgets/groups/select_color.dart';
import 'package:admu_student_app/screens/qpi/add_qpi.dart';

class AddClassPage extends StatefulWidget {
  final bool inEnlistment;
  final bool isEditing;

  AddClassPage({this.inEnlistment = false, this.isEditing = false});
  @override
  _AddClassPageState createState() => _AddClassPageState();
}

class _AddClassPageState extends State<AddClassPage> {
  TextEditingController _codeCtrl = TextEditingController();
  TextEditingController _sectionCtrl = TextEditingController();
  TextEditingController _yearCtrl = TextEditingController();
  TextEditingController _unitCtrl = TextEditingController();
  TextEditingController _profCtrl = TextEditingController();

  _AddClassPageState();

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
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Done',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.white,
                    ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 48, 16, 0),
        child: Column(
          children: [
            Center(
              child: Text(
                '${widget.isEditing ? 'Edit' : 'Add'} Class',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                // Text Field at the Left
                Expanded(child: InputGroup('Course Code', _codeCtrl)),
                SizedBox(width: 20),
                // Text at the Right
                Expanded(child: InputGroup('Section', _sectionCtrl)),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                // Text Field at the Left
                Expanded(child: InputGroup('Year Level', _yearCtrl)),
                SizedBox(width: 20),
                // Text at the Right
                Expanded(child: InputGroup('Units', _unitCtrl)),
              ],
            ),
            Row(
              children: [
                // Expanded(child: SelectSemesterGroup()),
                // Quarter Select goes here
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Container(
                // Expanded(child: SelectColor())
                ),
            SizedBox(
              height: 24,
            ),
            Container(
                // Container for the Date Select
                ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                // Row for Time Selectors
              ],
            ),
            widget.inEnlistment
                ? Expanded(
                    child: InputGroup('Name of Professor', _profCtrl),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}