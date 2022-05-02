import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';

enum ButtonSize {
  long,
  medium,
  short,
  square,
}

class CustomButton extends StatelessWidget {
  final ButtonSize size;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  final bool outlined;

  final List<BoxShadow> shadows;

  CustomButton(
    this.size,
    this.text,
    this.buttonColor,
    this.textColor,
    this.onPressed, {
    this.outlined = false,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    double width;
    if (size == ButtonSize.long)
      width = 382;
    else if (size == ButtonSize.medium)
      width = 224;
    else if (size == ButtonSize.short)
      width = 128;
    else
      width = 64;

    return Container(
      width: width,
      height: 64,
      decoration: BoxDecoration(
        color: outlined ? Colors.transparent : buttonColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: outlined ? buttonColor : Colors.transparent,
          width: 1.0,
        ),
        boxShadow: shadows,
      ),
      child: TextButton(
        onPressed: () {
          if (onPressed != null) onPressed();
        },
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: textColor, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
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
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: selected
            ? Border.all(color: AppColors.SECONDARY_MAIN, width: 4.0)
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
