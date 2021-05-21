import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';

class SelectDateGroup extends StatefulWidget {
  final String label;

  SelectDateGroup(this.label);

  @override
  _SelectDateGroupState createState() => _SelectDateGroupState();
}

class _SelectDateGroupState extends State<SelectDateGroup> {
  DateTime _date;

  @override
  void initState() {
    super.initState();

    _date = DateTime.now();
  }

  void _onTap() {
    /*if (Platform.isIOS) {
      // show cupertino
      print('show cupertino time picker');
    } else {
      // show material
      print('show material time picker');
    }*/
    setState(() {
      _date = _date.add(Duration(days: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // label
        Text(
          widget.label,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: AppColors.GRAY_LIGHT[2]),
        ),
        SizedBox(height: 8),
        // button
        InkWell(
          onTap: _onTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.GRAY_LIGHT[2],
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            height: 56,
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${_date.month.toString().padLeft(2, '0')}/${_date.day.toString().padLeft(2, '0')}/${_date.year.toString().padLeft(4, '0')}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: AppColors.GRAY_DARK[0]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
