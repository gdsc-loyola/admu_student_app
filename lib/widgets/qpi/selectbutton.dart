import 'package:flutter/material.dart';

class DateSelect extends StatefulWidget {
  final Color buttonColor;
  final Color textColor;
  final Color labelColor;

  DateSelect(this.labelColor, this.buttonColor, this.textColor);

  @override
  _DateSelectState createState() => _DateSelectState();
}

class _DateSelectState extends State<DateSelect> {
  
  bool _isSelected = false;

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
                style: TextStyle(color: widget.labelColor),
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
                    color: _isSelected ? Colors.blue:widget.buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'M',
                      style: TextStyle(color: widget.textColor),
                    )),
              ),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: widget.buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child:
                        Text('T', style: TextStyle(color: widget.textColor))),
              ),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: widget.buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child:
                        Text('W', style: TextStyle(color: widget.textColor))),
              ),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: widget.buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child:
                        Text('Th', style: TextStyle(color: widget.textColor))),
              ),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: widget.buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child:
                        Text('F', style: TextStyle(color: widget.textColor))),
              ),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: widget.buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child:
                        Text('S', style: TextStyle(color: widget.textColor))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class SemSelect extends StatefulWidget {
  final Color buttonColor;
  final Color textColor;
  final Color labelColor;

  SemSelect(this.labelColor, this.buttonColor, this.textColor);

  @override
  _SemSelectState createState() => _SemSelectState();
}

class _SemSelectState extends State<SemSelect> {
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
                style: TextStyle(color: widget.labelColor),
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
                    color: widget.buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('1', style: TextStyle(color: widget.textColor))),
              ),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: widget.buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('2', style: TextStyle(color: widget.textColor))),
              ),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: widget.buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('IS', style: TextStyle(color: widget.textColor))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QtrSelect extends StatefulWidget {
  final Color buttonColor;
  final Color textColor;
  final Color labelColor;

  QtrSelect(this.labelColor, this.buttonColor, this.textColor);

  @override
  _QtrSelectState createState() => _QtrSelectState();
}

class _QtrSelectState extends State<QtrSelect> {
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
                style: TextStyle(color: widget.labelColor),
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
                    color: widget.buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('1', style: TextStyle(color: widget.textColor))),
              ),
              Container(
                width: 41,
                height: 54,
                decoration: BoxDecoration(
                    color: widget.buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('2', style: TextStyle(color: widget.textColor))),
              ),
              Container(
                width: 41,
                height: 54,
                decoration: BoxDecoration(
                    color: widget.buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('3', style: TextStyle(color: widget.textColor))),
              ),
              Container(
                width: 41,
                height: 54,
                decoration: BoxDecoration(
                    color: widget.buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                    onPressed: () {},
                    child: Text('4', style: TextStyle(color: widget.textColor))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
