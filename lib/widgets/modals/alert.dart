import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class AlertModal {
  static Future<void> showAlert(
    BuildContext context, {
    IconData iconData = Icons.warning_rounded,
    Color iconColor = AppColors.ERROR_MAIN,
    String header = 'Delete?',
    String description = 'You will not be able to recover this.',
    String acceptText = 'Delete',
    String declineText = 'Nah, just kidding!',
    VoidCallback onAccept,
    VoidCallback onDecline,
    Color acceptColor = AppColors.ERROR_MAIN,
    bool showDecline = true,
  }) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (context, _, __) {
        return Center(
          child: _AlertModal(
            iconData: iconData,
            iconColor: iconColor,
            header: header,
            description: description,
            acceptText: acceptText,
            declineText: declineText,
            onAccept: onAccept,
            onDecline: onDecline,
            acceptColor: acceptColor,
            showDecline: showDecline,
          ),
        );
      },
    );
  }

  static Future<void> showError(
    BuildContext context,
    String message, {
    String header = 'Invalid Input',
  }) async {
    await showAlert(
      context,
      iconData: Icons.error_outline_rounded,
      header: header,
      description: 'Please try again and make sure that $message',
      acceptText: 'Got it!',
      showDecline: false,
    );
  }

  static Future<void> showNegativeError(
    BuildContext context, [
    String type = 'number input',
  ]) async {
    await showError(
      context,
      'your $type is not a negative value.',
    );
  }

  static Future<void> showDecimalOrNegativeError(
    BuildContext context, [
    String type = 'number input',
  ]) async {
    await showError(
      context,
      'your $type is not a decimal or a negative value.',
    );
  }

  static Future<void> showIncompleteError(BuildContext context) async {
    await showError(
      context,
      'all required fields (*) are filled!',
      header: 'Incomplete Input',
    );
  }

  static Future<void> showInverseTimeError(BuildContext context) async {
    await showError(
      context,
      'your start time is earlier than your end time.',
    );
  }
}

class _AlertModal extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;

  final String header;
  final String description;
  final String acceptText;
  final String declineText;

  final VoidCallback onAccept;
  final VoidCallback onDecline;

  final Color acceptColor;

  final bool showDecline;

  _AlertModal({
    this.iconData,
    this.iconColor,
    this.header,
    this.description,
    this.acceptText,
    this.declineText,
    this.onAccept,
    this.onDecline,
    this.acceptColor,
    this.showDecline,
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
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // icon
          Icon(iconData, color: iconColor, size: 75),
          SizedBox(height: 8),

          // header
          Text(
            header,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5.copyWith(
                color: AppColors.GRAY_DARK[0], fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),

          // text
          if (description != null && description.isNotEmpty)
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: AppColors.GRAY_DARK[0], fontWeight: FontWeight.w500),
            ),
          if (description != null && description.isNotEmpty)
            SizedBox(height: 40),

          // accept
          CustomButton(
            ButtonSize.medium,
            acceptText,
            acceptColor,
            AppColors.GRAY_LIGHT[2],
            () {
              Navigator.of(context).pop();
              if (onAccept != null) onAccept();
            },
            shadows: [AppEffects.SHADOW],
          ),

          if (showDecline) SizedBox(height: 16),

          // reject
          if (showDecline)
            CustomButton(
              ButtonSize.medium,
              declineText,
              AppColors.GRAY_DARK[1], // temporary?
              AppColors.GRAY_DARK[1],
              () {
                Navigator.of(context).pop();
                if (onDecline != null) onDecline();
              },
              outlined: true,
            ),
        ],
      ),
    );
  }
}
