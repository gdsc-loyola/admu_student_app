import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';

class DeleteModal {
  static Future<void> showAlert(
    BuildContext context,
    VoidCallback onDelete,
  ) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              color: Color(0xFFFFD4C9), // TODO color is not in branding
            ),
            padding: EdgeInsets.only(top: 12, bottom: 6),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // icon
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      onDelete();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFF6F66), // TODO color not in branding
                        boxShadow: [AppEffects.SHADOW],
                      ),
                      width: 64,
                      height: 64,
                      child: Icon(
                        CupertinoIcons.delete,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4),

                // text
                Text(
                  'Delete',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.GRAY_DARK[0],
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
