import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/widgets/select_color.dart';

class SelectSemester extends StatefulWidget {
  @override
  _SelectSemesterState createState() => _SelectSemesterState();
}

class _SelectSemesterState extends State<SelectSemester> {
  List<bool> semSelected = List.generate(3, (index) => false);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: [
        CustomIcon(
          isSelected: semSelected[0],
          bgColor: Colors.white,
        ),
        CustomIcon(
          isSelected: semSelected[1],
          bgColor: Colors.white,
        ),
        CustomIcon(
          isSelected: semSelected[2],
          bgColor: Colors.white,
        ),
      ],
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
          buttonIndex < semSelected.length;
          buttonIndex++) {
            if (buttonIndex == index) {
              semSelected[buttonIndex] = !semSelected[buttonIndex];
            } else {
              semSelected[buttonIndex] = false;
            }
          }
        });
      },
      isSelected: semSelected,
      renderBorder: false,
      fillColor: Colors.transparent,
    );
  }
}
