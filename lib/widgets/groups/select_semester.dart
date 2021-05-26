import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/add_qpi_notifier.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class SelectSemesterGroup extends StatefulWidget {
  @override
  _SelectSemesterGroupState createState() => _SelectSemesterGroupState();
}

class _SelectSemesterGroupState extends State<SelectSemesterGroup> {
  @override
  Widget build(BuildContext context) {
    int selected = Provider.of<AddQPINotifier>(context).semNum;

    bool shouldShrink =
        ((MediaQuery.of(context).size.width - 16 * 2 - 20) / 2) < (56 * 3 + 4 * 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Semester',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: AppColors.GRAY_LIGHT[2]),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // same as DateSelect
            // this should be SquareButton
            ShrinkingButton(
              selected: selected == 0 ? true : false,
              text: 'IS',
              onPressed: () =>
                  Provider.of<AddQPINotifier>(context, listen: false).semNum =
                      0,
              shrink: shouldShrink,
            ),
            SizedBox(width: 4),
            ShrinkingButton(
              selected: selected == 1 ? true : false,
              text: '1',
              onPressed: () =>
                  Provider.of<AddQPINotifier>(context, listen: false).semNum =
                      1,
              shrink: shouldShrink,
            ),
            SizedBox(width: 4),
            ShrinkingButton(
              selected: selected == 2 ? true : false,
              text: '2',
              onPressed: () =>
                  Provider.of<AddQPINotifier>(context, listen: false).semNum =
                      2,
              shrink: shouldShrink,
            ),
          ],
        ),
      ],
    );
  }
}
