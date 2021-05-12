import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';

class CircularCheckMark extends StatelessWidget {
  final bool isDone;
  final VoidCallback onTap;

  CircularCheckMark({this.isDone = false, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: isDone
              ? Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.SECONDARY_MAIN,
                  size: 32,
                )
              : Container(
                  width: 27,
                  height: 27,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(width: 2.0, color: AppColors.GRAY_LIGHT[0]),
                  ),
                ),
        ),
      ),
    );
  }
}
