import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';

class PomodoroButtonRow extends StatefulWidget {
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;
  final VoidCallback onPressed3;

  final int selected;
  final bool blocked;

  PomodoroButtonRow(
    this.onPressed1,
    this.onPressed2,
    this.onPressed3, {
    this.selected = 0,
    this.blocked = false,
  });

  @override
  _PomodoroButtonRowState createState() => _PomodoroButtonRowState();
}

class _PomodoroButtonRowState extends State<PomodoroButtonRow> {
  int _selected;

  @override
  void initState() {
    super.initState();

    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      // padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.PRIMARY_LIGHT,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          width: 2,
          color: AppColors.PRIMARY_ALT,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 1
          Expanded(
            child: InkWell(
              onTap: () {
                if (widget.blocked) return;
                setState(() {
                  _selected = 0;
                  widget.onPressed1();
                });
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: _selected == 0
                      ? AppColors.PRIMARY_MAIN
                      : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  // border: Border.all(
                  //   width: 2,
                  //   color: _selected == 0
                  //       ? AppColors.PRIMARY_ALT
                  //       : Colors.transparent,
                  // ),
                  boxShadow: _selected == 0
                      ? [AppEffects.SHADOW]
                      : [],
                ),
                child: Center(
                  child: Text('Short Break',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: AppColors.GRAY_LIGHT[2],
                            fontWeight: _selected == 0
                                ? FontWeight.w500
                                : FontWeight.normal,
                          )),
                ),
              ),
            ),
          ),

          // 2
          Expanded(
            child: InkWell(
              onTap: () {
                if (widget.blocked) return;
                setState(() {
                  _selected = 1;
                  widget.onPressed2();
                });
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: _selected == 1
                      ? AppColors.PRIMARY_MAIN
                      : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  // border: Border.all(
                  //   width: 2,
                  //   color: _selected == 1
                  //       ? AppColors.PRIMARY_ALT
                  //       : Colors.transparent,
                  // ),
                  boxShadow: _selected == 1
                      ? [AppEffects.SHADOW]
                      : [],
                ),
                child: Center(
                  child: Text('Pomodoro',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: AppColors.GRAY_LIGHT[2],
                            fontWeight: _selected == 1
                                ? FontWeight.w500
                                : FontWeight.normal,
                          )),
                ),
              ),
            ),
          ),

          // 3
          Expanded(
            child: InkWell(
              onTap: () {
                if (widget.blocked) return;
                setState(() {
                  _selected = 2;
                  widget.onPressed3();
                });
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: _selected == 2
                      ? AppColors.PRIMARY_MAIN
                      : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  // border: Border.all(
                  //   width: 2,
                  //   color: _selected == 2
                  //       ? AppColors.PRIMARY_ALT
                  //       : Colors.transparent,
                  // ),
                  boxShadow: _selected == 2
                      ? [AppEffects.SHADOW]
                      : [],
                ),
                child: Center(
                  child: Text('Long Break',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: AppColors.GRAY_LIGHT[2],
                            fontWeight: _selected == 2
                                ? FontWeight.w500
                                : FontWeight.normal,
                          )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
