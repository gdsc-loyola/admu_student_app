import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class HelpModal extends StatelessWidget {
  final List<String> strings;
  final String acceptText;
  final VoidCallback onAccept;

  HelpModal({
    @required this.strings,
    this.acceptText = 'Got it!',
    this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      padding: EdgeInsets.fromLTRB(16, 86, 16, 62),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // heading
          Text(
            'How-To',
            style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.w500, color: AppColors.GRAY_DARK[0]),
          ),

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
                    // temporary sizes
                    width: 32,
                    height: 32,
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: AppColors.GRAY_LIGHT[2]),
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

          // button
          ShortButton(
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
