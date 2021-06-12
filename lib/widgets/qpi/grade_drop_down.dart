import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';

class GradeDropDown extends StatefulWidget {
  final int selected;
  final Function(int) onValueChange;

  GradeDropDown({this.selected, this.onValueChange});

  @override
  _GradeDropDownState createState() => _GradeDropDownState();
}

class _GradeDropDownState extends State<GradeDropDown> {
  int _selected = 1;

  @override
  void initState() {
    super.initState();

    if (widget.selected != null) _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(
          color: AppColors.GRAY_LIGHT[2],
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            value: _selected,
            items: [
              DropdownMenuItem(child: Text("A"), value: 1),
              DropdownMenuItem(child: Text("B+"), value: 2),
              DropdownMenuItem(child: Text("B"), value: 3),
              DropdownMenuItem(child: Text("C+"), value: 4),
              DropdownMenuItem(child: Text("C"), value: 5),
              DropdownMenuItem(child: Text("D"), value: 6),
              DropdownMenuItem(child: Text("F/W"), value: 7),
            ],
            onChanged: (value) {
              setState(() {
                _selected = value;
                if (widget.onValueChange != null)
                  widget.onValueChange(_selected);
              });
            }),
      ),
    );
  }
}
