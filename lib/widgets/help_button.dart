import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';


class HelpButton extends StatelessWidget {
  HelpButton({
    Key key,
    this.isInverted = false,
  }) : super(key: key);

  final bool isInverted;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){},
      icon: Icon(
        CupertinoIcons.question_circle_fill,
        color: isInverted == true ? Colors.white : AppColors.PRIMARY_MAIN,
      ),
      iconSize: isInverted == true ? 32 : 32,
      splashRadius: 20,
      alignment: Alignment.topCenter,
      tooltip: 'This is your Total QPI',
    );
  }
}
