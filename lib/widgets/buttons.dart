import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';

class LongButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  LongButton(this.text, this.buttonColor, this.textColor, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 224,
      height: 64,
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextButton(
        onPressed: () => onPressed(),
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}

class ShortButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  ShortButton(this.text, this.buttonColor, this.textColor, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      height: 64,
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          text,
          style:
              Theme.of(context).textTheme.headline6.copyWith(color: textColor),
        ),
      ),
    );
  }
}

// used?
class SquareButton extends StatelessWidget {
  final String text;
  // final Color buttonColor;
  // final Color textColor;
  final VoidCallback onPressed;

  final bool selected;

  SquareButton({
    this.text = '',
    // this.buttonColor = Colors.white,
    // this.textColor = Colors.black,
    this.onPressed,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.GRAY_LIGHT[2],
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: selected ? Border.all(color: Colors.black) : null, // temporary
      ),
      child: TextButton(
        onPressed: () {
          if (onPressed != null) onPressed();
        },
        child: Text(
          '$text',
          style: TextStyle(color: AppColors.GRAY_DARK[0]),
        ),
      ),
    );
  }
}

// used in quarter and sem buttons
class ShrinkingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool selected;
  final bool shrink;

  ShrinkingButton({
    this.text = '',
    this.onPressed,
    this.selected,
    this.shrink = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = Container(
      width: shrink ? null : 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.GRAY_LIGHT[2],
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: selected
            ? Border.all(color: AppColors.SECONDARY_MAIN, width: 2.0)
            : null,
      ),
      child: TextButton(
        onPressed: () {
          if (onPressed != null) onPressed();
        },
        child: Text(
          '$text',
          style: TextStyle(color: AppColors.GRAY_DARK[0]),
        ),
      ),
    );

    if (shrink)
      return Expanded(child: button);
    else
      return button;
  }
}

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
          borderRadius: BorderRadius.all(Radius.circular(5))),
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
