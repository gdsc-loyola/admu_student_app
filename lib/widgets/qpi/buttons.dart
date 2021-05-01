import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;

  const LongButton(this.text, this.buttonColor, this.textColor); 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 219,
      height: 56,
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextButton(
        onPressed: () {},
        child: Text(text, style: TextStyle(color: textColor),),
      ),
    );
  }
}

class ShortButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;

  const ShortButton(this.text, this.buttonColor, this.textColor); 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      height: 56,
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextButton(
        onPressed: () {},
        child: Text(text, style: TextStyle(color: textColor),),
      ),
    );
  }
}
