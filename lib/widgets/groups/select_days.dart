import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class SelectDaysGroup extends StatefulWidget {
  @override
  _SelectDaysGroupState createState() => _SelectDaysGroupState();
}

class _SelectDaysGroupState extends State<SelectDaysGroup> {
  List<bool> _selected = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    bool shouldShrink =
        (MediaQuery.of(context).size.width - 16 * 2) < (56 * 6 + 8 * 5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
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
              selected: _selected[0],
              text: 'M',
              shrink: shouldShrink,
              onPressed: () {
                setState(() {
                  _selected[0] = !_selected[0];
                });
              },
            ),
            SizedBox(width: 8),
            ShrinkingButton(
              selected: _selected[1],
              text: 'T',
              shrink: shouldShrink,
              onPressed: () {
                setState(() {
                  _selected[1] = !_selected[1];
                });
              },
            ),
            SizedBox(width: 8),
            ShrinkingButton(
              selected: _selected[2],
              text: 'W',
              shrink: shouldShrink,
              onPressed: () {
                setState(() {
                  _selected[2] = !_selected[2];
                });
              },
            ),
            SizedBox(width: 8),
            ShrinkingButton(
              selected: _selected[3],
              text: 'Th',
              shrink: shouldShrink,
              onPressed: () {
                setState(() {
                  _selected[3] = !_selected[3];
                });
              },
            ),
            SizedBox(width: 8),
            ShrinkingButton(
              selected: _selected[4],
              text: 'F',
              shrink: shouldShrink,
              onPressed: () {
                setState(() {
                  _selected[4] = !_selected[4];
                });
              },
            ),
            SizedBox(width: 8),
            ShrinkingButton(
              selected: _selected[5],
              text: 'S',
              shrink: shouldShrink,
              onPressed: () {
                setState(() {
                  _selected[5] = !_selected[5];
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
