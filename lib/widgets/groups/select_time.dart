import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';

class SelectTimeGroup extends StatefulWidget {
  final String label;
  final TimeOfDay time;

  final Function(TimeOfDay) onTimeChange;

  SelectTimeGroup(this.label, {this.time, this.onTimeChange});

  @override
  _SelectTimeGroupState createState() => _SelectTimeGroupState();
}

class _SelectTimeGroupState extends State<SelectTimeGroup> {
  TimeOfDay _time;

  @override
  void initState() {
    super.initState();

    if (widget.time != null) _time = widget.time;
  }

  void _onTap(BuildContext context) async {
    if (kIsWeb || !Platform.isIOS) {
    // if (false) { // testing
      // show material

      TimeOfDay nTime = await showTimePicker(
        context: context,
        initialTime: _time == null
            ? TimeOfDay(hour: TimeOfDay.now().hour, minute: 0)
            : _time,
      );

      if (nTime != null) {
        setState(() {
          _time = nTime;
        });

        if (widget.onTimeChange != null) widget.onTimeChange(_time);
      }
    } else {
      // show cupertino

      TimeOfDay nTime;

      await showCupertinoModalPopup<void>(
        context: context,
        builder: (ctx) {
          TimeOfDay cur;

          return Container(
            color: Colors.white,
            height: 256,
            child: Column(
              children: [
                // buttons
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // cancel
                    TextButton(
                      onPressed: () {
                        nTime = null;
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),

                    // header
                    Expanded(
                      child: Center(
                        child: Text('Time', style: Theme.of(context).textTheme
                            .bodyText1),
                      ),
                    ),

                    // done
                    TextButton(
                      onPressed: () {
                        nTime = cur;
                        Navigator.of(context).pop();
                      },
                      child: Text('Done'),
                    ),
                  ],
                ),

                // picker
                Expanded(child:
                  CupertinoDatePicker(
                    // backgroundColor: AppColors.GRAY_LIGHT[2],
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (dt) {
                      cur = TimeOfDay(hour: dt.hour, minute: dt.minute);
                    },
                    initialDateTime: _time == null
                        ? DateTime(DateTime.now().year, DateTime.now().month,
                            DateTime.now().day)
                        : DateTime(DateTime.now().year, DateTime.now().month,
                            DateTime.now().day, _time.hour, _time.minute),
                  ),
                ),
              ],
            ),
          );
        },
      );

      if (nTime != null) {
        setState(() {
          _time = nTime;
        });

        if (widget.onTimeChange != null) widget.onTimeChange(_time);
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
        // buttons
        InkWell(
          onTap: () => _onTap(context),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.GRAY_LIGHT[2],
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            height: 56,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _time == null
                        ? '0:00 AM / PM'
                        : '${_time.hour > 12 ? (_time.hour - 12) : (_time.hour == 0 ? 12 : _time.hour)}:${_time.minute.toString().padLeft(2, '0')} ${_time.hour >= 12 ? 'PM' : 'AM'}',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: _time == null
                            ? AppColors.GRAY_DARK[2]
                            : AppColors.GRAY_DARK[0]),
                  ),
                ),

                // clear
                if (_time != null)
                  InkWell(
                    child: Icon(
                      CupertinoIcons.clear_circled_solid,
                      color: AppColors.GRAY_LIGHT[0],
                      size: 26,
                    ),
                    onTap: () {
                      setState(() {
                        _time = null;
                        if (widget.onTimeChange != null)
                          widget.onTimeChange(_time);
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
