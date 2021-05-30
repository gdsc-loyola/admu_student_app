import 'package:flutter/material.dart';

import 'package:admu_student_app/widgets/groups/input_group.dart';
import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class AddTask extends StatelessWidget {
  TextEditingController _eventCtrl = TextEditingController();
  TextEditingController _tagCtrl = TextEditingController();
  TextEditingController _agendaCtrl = TextEditingController();

  final bool isEditing;

  AddTask({this.isEditing = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.close_rounded),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Done',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: AppColors.GRAY_LIGHT[2]),
                ))
          ],
        ),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(16, 43, 16, 0),
        color: AppColors.PRIMARY_MAIN,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${isEditing ? 'Edit' : 'Add'} Event',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: AppColors.GRAY_LIGHT[2]),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputGroup('Event', _eventCtrl),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              // Time Input Field goes here
              Row(
                children: [
                  Expanded(
                    child: InputGroup('Tags', _tagCtrl),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: InputGroup('Agenda', _agendaCtrl),
                  ),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              isEditing? LongButton('Delete Event', AppColors.SECONDARY_MAIN,
                  AppColors.GRAY_LIGHT[2], () {}):SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
