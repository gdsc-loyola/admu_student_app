import 'package:flutter/material.dart';

class DateSelect extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final Color labelColor;

  const DateSelect(this.labelColor, this.buttonColor, this.textColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 384,
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "Date",
                style: TextStyle(color: labelColor),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // I think a listview builder might be a better way to create this but can't seem to make it work yet

              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'M',
                      style: TextStyle(color: textColor),
                    )),
              ),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('T', style: TextStyle(color: textColor))),
              ),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('W', style: TextStyle(color: textColor))),
              ),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('Th', style: TextStyle(color: textColor))),
              ),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('F', style: TextStyle(color: textColor))),
              ),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('S', style: TextStyle(color: textColor))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Data for the potential listview builder - unused
class DateData {
  static final getData = ["M", "T", "W", "Th", "F", "S", "Sun"];
}

class SemSelect extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final Color labelColor;

  const SemSelect(this.labelColor, this.buttonColor, this.textColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 177,
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Semester",
                style: TextStyle(color: labelColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // same as DateSelect

              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('1', style: TextStyle(color: textColor))),
              ),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('2', style: TextStyle(color: textColor))),
              ),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('IS', style: TextStyle(color: textColor))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QtrSelect extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final Color labelColor;

  const QtrSelect(this.labelColor, this.buttonColor, this.textColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 177,
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Quarter",
                style: TextStyle(color: labelColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // same as DateSelect

              Container(
                width: 41,
                height: 54,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('1', style: TextStyle(color: textColor))),
              ),
              Container(
                width: 41,
                height: 54,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('2', style: TextStyle(color: textColor))),
              ),
              Container(
                width: 41,
                height: 54,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('3', style: TextStyle(color: textColor))),
              ),
              Container(
                width: 41,
                height: 54,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('4', style: TextStyle(color: textColor))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
