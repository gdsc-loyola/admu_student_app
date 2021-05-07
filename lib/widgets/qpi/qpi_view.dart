import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';

class QPIView extends StatelessWidget {
  final double value;

  QPIView({@required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.PRIMARY_LIGHT,
      ),
      height: 64,
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${value.toStringAsFixed(2)}',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
