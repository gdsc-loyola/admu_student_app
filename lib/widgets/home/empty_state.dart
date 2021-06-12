import 'package:admu_student_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/main.dart';

class EmptyState extends StatelessWidget {
  final String topText;
  final String bottomText;

  const EmptyState({Key key, this.topText = '', this.bottomText = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              "onboarding.png",
              width: 86,
              height: 86,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            topText,
            style: Theme.of(context).textTheme.headline6.copyWith(color: AppColors.GRAY_DARK[1]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
          child: Text(
            bottomText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.GRAY_DARK[2]),
          ),
        ),
      ],
    );
  }
}
