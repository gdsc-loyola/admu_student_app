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
        ToggleButtons(
          children: [
            ShrinkingButton(
              selected: _selected[0],
              text: 'M',
              shrink: shouldShrink,
            ),
            // SizedBox(width: 4),
            ShrinkingButton(
              selected: _selected[1],
              text: 'T',
              shrink: shouldShrink,
            ),
            // SizedBox(width: 4),
            ShrinkingButton(
              selected: _selected[2],
              text: 'W',
              shrink: shouldShrink,
            ),
            // SizedBox(width: 4),
            ShrinkingButton(
              selected: _selected[3],
              text: 'Th',
              shrink: shouldShrink,
            ),
            // SizedBox(width: 4),
            ShrinkingButton(
              selected: _selected[4],
              text: 'F',
              shrink: shouldShrink,
            ),
            // SizedBox(width: 4),
            ShrinkingButton(
              selected: _selected[5],
              text: 'S',
              shrink: shouldShrink,
            ),
          ],
          onPressed: (i) {
            setState(() {
              _selected[i] = !_selected[i];
            });
          },
          isSelected: _selected,
          renderBorder: false,
          fillColor: Colors.transparent,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     ShrinkingButton(
        //       selected: selected == 0 ? true : false,
        //       text: 'M',
        //       shrink: shouldShrink,
        //     ),
        //     SizedBox(width: 4),
        //     ShrinkingButton(
        //       selected: selected == 1 ? true : false,
        //       text: 'T',
        //       shrink: shouldShrink,
        //     ),
        //     SizedBox(width: 4),
        //     ShrinkingButton(
        //       selected: selected == 2 ? true : false,
        //       text: 'W',
        //       shrink: shouldShrink,
        //     ),
        //     SizedBox(width: 4),
        //     ShrinkingButton(
        //       selected: selected == 3 ? true : false,
        //       text: 'Th',
        //       shrink: shouldShrink,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
