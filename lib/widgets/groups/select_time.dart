import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';

class SelectTimeGroup extends StatefulWidget {
  final String label;
  final TimeOfDay time;

  SelectTimeGroup(this.label, {this.time});

  @override
  _SelectTimeGroupState createState() => _SelectTimeGroupState();
}

class _SelectTimeGroupState extends State<SelectTimeGroup> {
  TimeOfDay _time;
  // DateTime _time;

  @override
  void initState() {
    super.initState();

    if (widget.time != null) _time = widget.time;
  }

  void _onTap(BuildContext context) async {
    if (kIsWeb || !Platform.isIOS) {
      // show material
      print('show material time picker');

      TimeOfDay nTime = await showTimePicker(
        context: context,
        initialTime: _time == null ? TimeOfDay.now() : _time,
      );

      if (nTime != null)
        setState(() {
          _time = nTime;
        });
    } else {
      // show cupertino
      print('show cupertino time picker');
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
          child: Row(
            children: [
              // time
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.GRAY_LIGHT[2],
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  height: 56,
                  child: Center(
                    child: Text(
                      _time == null
                          ? '00:00'
                          : '${_time.hour > 12 ? (_time.hour - 12) : _time.hour}:${_time.minute.toString().padLeft(2, '0')}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: _time == null
                              ? AppColors.GRAY_DARK[2]
                              : AppColors.GRAY_DARK[0]),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4), // width?
              // AM PM
              Container(
                decoration: BoxDecoration(
                  color: AppColors.GRAY_LIGHT[2],
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                width: 100,
                height: 56,
                padding: EdgeInsets.all(4), // original 3,3,3,5
                child: Row(
                  children: [
                    // AM
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: AppColors.GRAY_LIGHT[2],
                        boxShadow: _time == null || (_time.hour >= 12)
                            ? []
                            : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 1,
                                  offset: Offset(0, 3),
                                ),
                              ],
                      ),
                      width: 46,
                      child: Center(
                        child: Text(
                          'AM',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: _time == null || (_time.hour >= 12)
                                  ? AppColors.GRAY_DARK[2]
                                  : AppColors.GRAY_DARK[0]),
                        ),
                      ),
                    ),
                    // PM
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: AppColors.GRAY_LIGHT[2],
                        boxShadow: _time == null || (_time.hour >= 12)
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 1,
                                  offset: Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      width: 46,
                      child: Center(
                        child: Text(
                          'PM',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: _time == null || (_time.hour >= 12)
                                  ? AppColors.GRAY_DARK[0]
                                  : AppColors.GRAY_DARK[2]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
