import 'package:flutter/material.dart';

class LongButton extends StatefulWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
LongButton(this.text, this.buttonColor, this.textColor); 

  @override
  _LongButtonState createState() => _LongButtonState();
}

class _LongButtonState extends State<LongButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 219,
      height: 56,
      decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextButton(
        onPressed: () {},
        child: Text(widget.text, style: TextStyle(color: widget.textColor),),
      ),
    );
  }
}

class ShortButton extends StatefulWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;

  ShortButton(this.text, this.buttonColor, this.textColor); 

  @override
  _ShortButtonState createState() => _ShortButtonState();
}

class _ShortButtonState extends State<ShortButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      height: 56,
      decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextButton(
        onPressed: () {},
        child: Text(widget.text, style: TextStyle(color: widget.textColor),),
      ),
    );
  }
}
