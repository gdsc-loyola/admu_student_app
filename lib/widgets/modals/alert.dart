import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class AlertModal extends StatelessWidget {
  final IconData iconData;

  final String header;
  final String description;
  final String acceptText;
  final String declineText;

  final VoidCallback onAccept;
  final VoidCallback onDecline;

  AlertModal({
    this.iconData = Icons.warning_rounded,
    this.header = 'Delete?',
    this.description = 'You will not be able to recover it.',
    this.acceptText = 'Delete',
    this.declineText = 'Nah, just kidding!',
    this.onAccept,
    this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      padding: EdgeInsets.fromLTRB(16, 56, 16, 56),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // icon
          Icon(Icons.warning_rounded, color: AppColors.ERROR_MAIN, size: 64),
          SizedBox(height: 8),

          // header
          Text(
            header,
            style: Theme.of(context).textTheme.headline5.copyWith(
                color: AppColors.GRAY_DARK[0], fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),

          // text
          Text(
            description,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: AppColors.GRAY_DARK[0], fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 40),

          // accept
          ShortButton(
            acceptText,
            AppColors.ERROR_MAIN,
            AppColors.GRAY_LIGHT[2],
            () {
              if (onAccept != null) onAccept();
              Navigator.of(context).pop();
            },
            shadows: [AppEffects.SHADOW],
          ),
          SizedBox(height: 16),

          // reject
          ShortButton(
            declineText,
            AppColors.GRAY_DARK[1], // temporary?
            AppColors.GRAY_DARK[1],
            () {
              if (onDecline != null) onDecline();
              Navigator.of(context).pop();
            },
            shadows: [AppEffects.SHADOW],
            outlined: true,
          ),
        ],
      ),
    );
  }
}
