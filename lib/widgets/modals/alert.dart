import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class AlertModal {
  static Future<void> showAlert(
    BuildContext context, {
    IconData iconData = Icons.warning_rounded,
    String header = 'Delete?',
    String description = 'You will not be able to recover this.',
    String acceptText = 'Delete',
    String declineText = 'Nah, just kidding!',
    VoidCallback onAccept,
    VoidCallback onDecline,
  }) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (context, _, __) {
        return Center(
          child: _AlertModal(
            iconData: iconData,
            header: header,
            description: description,
            acceptText: acceptText,
            declineText: declineText,
            onAccept: onAccept,
            onDecline: onDecline,
          ),
        );
      },
    );
  }
}

class _AlertModal extends StatelessWidget {
  final IconData iconData;

  final String header;
  final String description;
  final String acceptText;
  final String declineText;

  final VoidCallback onAccept;
  final VoidCallback onDecline;

  _AlertModal({
    this.iconData,
    this.header,
    this.description,
    this.acceptText,
    this.declineText,
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
      margin: EdgeInsets.all(16),
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
          CustomButton(
            ButtonSize.medium,
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
          CustomButton(
            ButtonSize.medium,
            declineText,
            AppColors.GRAY_DARK[1], // temporary?
            AppColors.GRAY_DARK[1],
            () {
              if (onDecline != null) onDecline();
              Navigator.of(context).pop();
            },
            outlined: true,
          ),
        ],
      ),
    );
  }
}
