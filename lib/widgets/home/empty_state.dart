import 'package:admu_student_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/main.dart';

class EmptyState extends StatelessWidget {
  final String topText;
  final String bottomText;

  const EmptyState({Key key, this.topText = 'No Events Yet', this.bottomText = 'Rest up buddy! You may add events for today using the calendar page.'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
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
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: AppColors.GRAY_DARK[1]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Text(
              bottomText,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: AppColors.GRAY_DARK[2]),
            ),
          ),
        ],
      ),
    );
  }
}
