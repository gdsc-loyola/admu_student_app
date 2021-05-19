import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class SelectSemesterGroup extends StatefulWidget {
  @override
  _SelectSemesterGroupState createState() => _SelectSemesterGroupState();
}

class _SelectSemesterGroupState extends State<SelectSemesterGroup> {
  @override
  Widget build(BuildContext context) {
    // int selected = Provider.of<AddQPINotifier>(context).semNum;
    int selected = 0;

    bool shouldShrink =
        (MediaQuery.of(context).size.width - 16 * 2 - 20) / 4 < 64 * 4 + 8 * 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quarter',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: AppColors.GRAY_LIGHT[2]),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShrinkingButton(
              selected: selected == 0 ? true : false,
              text: '1',
              shrink: shouldShrink,
            ),
            SizedBox(width: 4),
            ShrinkingButton(
              selected: selected == 1 ? true : false,
              text: '2',
              shrink: shouldShrink,
            ),
            SizedBox(width: 4),
            ShrinkingButton(
              selected: selected == 2 ? true : false,
              text: '3',
              shrink: shouldShrink,
            ),
            SizedBox(width: 4),
            ShrinkingButton(
              selected: selected == 3 ? true : false,
              text: '4',
              shrink: shouldShrink,
            ),
          ],
        ),
      ],
    );
  }
}
