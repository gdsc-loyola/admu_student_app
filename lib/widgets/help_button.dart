import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){},
      icon: Icon(
        CupertinoIcons.question_circle_fill,
        color: AppColors.PRIMARY_MAIN,
      ),
      iconSize: 32,
      splashRadius: 20,
      alignment: Alignment.topCenter,
      tooltip: 'This is your Total QPI',
    );
  }
}
