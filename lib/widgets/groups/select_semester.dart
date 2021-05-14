import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // same as DateSelect
            // this should be SquareButton
            SquareButton(
              selected: selected == 0 ? true : false,
              text: 'IS',
              onPressed: () =>
                  Provider.of<AddQPINotifier>(context, listen: false).semNum =
                      0,
            ),
            SquareButton(
              selected: selected == 1 ? true : false,
              text: '1',
              onPressed: () =>
                  Provider.of<AddQPINotifier>(context, listen: false).semNum =
                      1,
            ),
            SquareButton(
              selected: selected == 2 ? true : false,
              text: '2',
              onPressed: () =>
                  Provider.of<AddQPINotifier>(context, listen: false).semNum =
                      2,
            ),
          ],
        ),
      ],
    );
  }
}
