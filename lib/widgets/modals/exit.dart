import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class ExitModal {
  static Future<void> showExit(
    BuildContext context, {
    IconData iconData = Icons.logout,
    String header = 'Exit?',
    String description = '',
    String acceptText = 'Exit',
    String declineText = 'Nah, just kidding!',
    VoidCallback onAccept,
    VoidCallback onDecline,
  }) async {
    await showGeneralDialog(
        context: context,
        pageBuilder: (contet, _, __) {
          return Center(
            child: _ExitModal(
              iconData: iconData,
              header: header,
              description: description,
              acceptText: acceptText,
              declineText: declineText,
              onAccept: onAccept,
              onDecline: onDecline,
            ),
          );
        });
  }
}

class _ExitModal extends StatelessWidget {
  final IconData iconData;

  final String header;
  final String description;
  final String acceptText;
  final String declineText;

  final VoidCallback onAccept;
  final VoidCallback onDecline;

  _ExitModal({
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
      padding: EdgeInsets.fromLTRB(32, 64, 32, 56), // old hor: 16
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // icon
          Icon(iconData, color: AppColors.ACCENTS[0], size: 64),
          SizedBox(height: 16),

          // header
          Text(
            header,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4.copyWith(
                color: AppColors.GRAY_DARK[0], fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16),

          // text
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: AppColors.GRAY_DARK[0], fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16),

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
