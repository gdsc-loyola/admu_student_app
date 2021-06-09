import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';

class SelectDateGroup extends StatefulWidget {
  final String label;
  final DateTime date;

  final Function(DateTime) onDateChange;

  SelectDateGroup(this.label, {this.date, this.onDateChange});

  @override
  _SelectDateGroupState createState() => _SelectDateGroupState();
}

class _SelectDateGroupState extends State<SelectDateGroup> {
  DateTime _date;

  @override
  void initState() {
    super.initState();

    if (widget.date != null) _date = widget.date;
  }

  void _onTap(BuildContext context) async {
    if (kIsWeb || !Platform.isIOS) {
      // show material

      DateTime nDate = await showDatePicker(
        context: context,
        initialDate: _date == null ? DateTime.now() : _date,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 10),
      );

      if (nDate != null) {
        setState(() {
          _date = nDate;
        });

        if (widget.onDateChange != null) widget.onDateChange(_date);
      }
    } else {
      // show cupertino

      DateTime nDate;

      await showCupertinoModalPopup<void>(
        context: context,
        builder: (ctx) {
          return SizedBox(
            height: 256,
            child: CupertinoDatePicker(
              backgroundColor: AppColors.GRAY_LIGHT[2],
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (dt) {
                nDate = dt;
              },
              initialDateTime: _date == null
                  ? DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day)
                  : _date,
              minimumDate: DateTime(DateTime.now().year - 10),
              maximumDate: DateTime(DateTime.now().year + 10),
            ),
          );
        },
      );

      if (nDate != null) {
        setState(() {
          _date = nDate;
        });

        if (widget.onDateChange != null) widget.onDateChange(_date);
      }
    }
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
          onTap: () => _onTap(context),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.GRAY_LIGHT[2],
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            height: 56,
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    _date == null
                        ? 'MM / DD / YYYY'
                        : '${_date.month.toString().padLeft(2, '0')} / ${_date.day.toString().padLeft(2, '0')} / ${_date.year.toString().padLeft(4, '0')}',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: _date == null
                            ? AppColors.GRAY_DARK[2]
                            : AppColors.GRAY_DARK[0]),
                  ),
                ),

                // clear
                InkWell(
                  child: Icon(
                    CupertinoIcons.clear_circled_solid,
                    color: AppColors.GRAY_LIGHT[0],
                    size: 26,
                  ),
                  onTap: () {
                    setState(() {
                      _date = null;
                      if (widget.onDateChange != null)
                        widget.onDateChange(_date);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
