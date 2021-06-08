import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class HelpModal {
  static Future<void> showHelp(
    BuildContext context, {
    String title = '',
    List<String> strings = const [],
    String acceptText = 'Got it!',
    VoidCallback onAccept,
  }) async {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, _, __) {
        return Center(
          child: _HelpModal(
            title: title,
            strings: strings,
            acceptText: acceptText,
            onAccept: onAccept,
          ),
        );
      },
    );
  }
}

class _HelpModal extends StatelessWidget {
  final String title;
  final List<String> strings;
  final String acceptText;
  final VoidCallback onAccept;

  _HelpModal({
    this.title,
    this.strings,
    this.acceptText,
    this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      padding: EdgeInsets.fromLTRB(32, 46, 32, 62), // original 16? temp
      width: double.infinity,
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // heading
          Text(
            'Tutorial',
            style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.w500, color: AppColors.GRAY_DARK[1]),
          ),

          // title
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: AppColors.GRAY_DARK[0])),

          // items
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: strings.length,
            itemBuilder: (_, index) {
              Widget row = Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // circle number
                  Container(
                    margin: EdgeInsets.only(right: 21),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.SECONDARY_MAIN,
                    ),
                    width: 32,
                    height: 32,
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.GRAY_LIGHT[2]),
                      ),
                    ),
                  ),

                  // text
                  Expanded(
                    child: Text(
                      strings[index],
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.GRAY_DARK[1]),
                    ),
                  ),
                ],
              );

              return Container(
                margin: EdgeInsets.only(top: 24),
                child: row,
              );
            },
          ),
          SizedBox(height: 32),

          // button
          CustomButton(
            ButtonSize.medium,
            acceptText,
            AppColors.PRIMARY_MAIN,
            AppColors.GRAY_LIGHT[2],
            () => Navigator.of(context).pop(),
            shadows: [AppEffects.SHADOW],
          ),
        ],
      ),
    );
  }
}
