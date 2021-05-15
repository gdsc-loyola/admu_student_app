import 'package:flutter/material.dart';

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
          style: Theme.of(context).textTheme.headline6.copyWith(color: textColor),
        ),
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  SquareButton(this.text, this.buttonColor, this.textColor, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextButton(
          onPressed: () {
            onPressed();
          },
          child: Text(
            '$text',
            style: TextStyle(color: textColor),
          )),
    );
  }
}

class ShrinkingButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  ShrinkingButton(this.text, this.buttonColor, this.textColor, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 41,
      height: 56,
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextButton(
          onPressed: () {
            onPressed();
          },
          child: Text(
            '$text',
            style: TextStyle(color: textColor),
          )),
    );
  }
}

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      height: 56,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            value: _value,
            items: [
              DropdownMenuItem(
                child: Text("A"),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text("B+"),
                value: 2,
              ),
              DropdownMenuItem(child: Text("B"), value: 3),
              DropdownMenuItem(child: Text("C+"), value: 4),
              DropdownMenuItem(child: Text("C"), value: 5),
              DropdownMenuItem(child: Text("D"), value: 6),
              DropdownMenuItem(child: Text("F/W"), value: 7)
            ],
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            }),
      ),
    );
  }
}


class ButtonRow extends StatefulWidget {
  final String text1;
  final String text2;
  final String text3;
  final VoidCallback return1;
  final VoidCallback return2;
  final VoidCallback return3;

  ButtonRow(this.text1, this.text2, this.text3, this.return1, this.return2,
      this.return3);

  @override
  _ButtonRowState createState() => _ButtonRowState();
}

class _ButtonRowState extends State<ButtonRow> {
  bool isSelected1 = true;
  bool isSelected2 = false;
  bool isSelected3 = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          height: 36.54,
          padding: EdgeInsets.fromLTRB(1.19, 1, 1.19, 2.54),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Item 1
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 33,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: isSelected1
                                ? Colors.grey.withOpacity(0.5)
                                : Colors.transparent,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3)),
                      ],
                      color: isSelected1 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isSelected1 = true;
                          isSelected2 = false;
                          isSelected3 = false;
                          widget.return1();
                        });
                      },
                      child: Text(
                        "${widget.text1}",
                        style: TextStyle(
                            color: isSelected1 ? Colors.black : Colors.grey[600]),
                      ),
                    ),
                  ),
                ),
                // Item 2
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 33,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: isSelected2
                                ? Colors.grey.withOpacity(0.5)
                                : Colors.transparent,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3)),
                      ],
                      color: isSelected2 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isSelected1 = false;
                          isSelected2 = true;
                          isSelected3 = false;
                          widget.return2();
                        });
                      },
                      child: Text(
                        "${widget.text2}",
                        style: TextStyle(
                            color: isSelected2 ? Colors.black : Colors.grey[600]),
                      ),
                    ),
                  ),
                ),
                // Item 3
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 33,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: isSelected3
                                ? Colors.grey.withOpacity(0.5)
                                : Colors.transparent,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3)),
                      ],
                      color: isSelected3 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isSelected1 = false;
                          isSelected2 = false;
                          isSelected3 = true;
                          widget.return3();
                        });
                      },
                      child: Text(
                        "${widget.text3}",
                        style: TextStyle(
                            color: isSelected3 ? Colors.black : Colors.grey[600]),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///// Code for Selector Buttons - Copy/Paste as needed

// class DateSelect extends StatefulWidget {
//   final Color buttonColor;
//   final Color textColor;
//   final Color labelColor;

//   DateSelect(this.labelColor, this.buttonColor, this.textColor);

//   @override
//   _DateSelectState createState() => _DateSelectState();
// }

// class _DateSelectState extends State<DateSelect> {
//   bool _isSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       width: 384,
//       height: 80,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Text(
//                 "Date",
//                 style: TextStyle(color: widget.labelColor),
//               )
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // I think a listview builder might be a better way to create this but can't seem to make it work yet

//               Container(
//                 width: 54,
//                 height: 54,
//                 decoration: BoxDecoration(
//                     color: _isSelected ? Colors.blue : widget.buttonColor,
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                 child: TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       'M',
//                       style: TextStyle(color: widget.textColor),
//                     )),
//               ),
//               Container(
//                 width: 54,
//                 height: 54,
//                 decoration: BoxDecoration(
//                     color: widget.buttonColor,
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                 child: TextButton(
//                     onPressed: () {},
//                     child:
//                         Text('T', style: TextStyle(color: widget.textColor))),
//               ),
//               Container(
//                 width: 54,
//                 height: 54,
//                 decoration: BoxDecoration(
//                     color: widget.buttonColor,
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                 child: TextButton(
//                     onPressed: () {},
//                     child:
//                         Text('W', style: TextStyle(color: widget.textColor))),
//               ),
//               Container(
//                 width: 54,
//                 height: 54,
//                 decoration: BoxDecoration(
//                     color: widget.buttonColor,
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                 child: TextButton(
//                     onPressed: () {},
//                     child:
//                         Text('Th', style: TextStyle(color: widget.textColor))),
//               ),
//               Container(
//                 width: 54,
//                 height: 54,
//                 decoration: BoxDecoration(
//                     color: widget.buttonColor,
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                 child: TextButton(
//                     onPressed: () {},
//                     child:
//                         Text('F', style: TextStyle(color: widget.textColor))),
//               ),
//               Container(
//                 width: 54,
//                 height: 54,
//                 decoration: BoxDecoration(
//                     color: widget.buttonColor,
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                 child: TextButton(
//                     onPressed: () {},
//                     child:
//                         Text('S', style: TextStyle(color: widget.textColor))),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

//////

class SemSelect extends StatefulWidget {
  final Color buttonColor;
  final Color textColor;

  SemSelect(this.buttonColor, this.textColor);

  @override
  _SemSelectState createState() => _SemSelectState();
}

class _SemSelectState extends State<SemSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 177,
      height: 54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
                    child:
                        Text('1', style: TextStyle(color: widget.textColor))),
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
                        Text('2', style: TextStyle(color: widget.textColor))),
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
                        Text('IS', style: TextStyle(color: widget.textColor))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//////

// class QtrSelect extends StatefulWidget {
//   final Color buttonColor;
//   final Color textColor;
//   final Color labelColor;

//   QtrSelect(this.labelColor, this.buttonColor, this.textColor);

//   @override
//   _QtrSelectState createState() => _QtrSelectState();
// }

// class _QtrSelectState extends State<QtrSelect> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       width: 177,
//       height: 80,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 "Quarter",
//                 style: TextStyle(color: widget.labelColor),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // same as DateSelect

//               Container(
//                 width: 41,
//                 height: 54,
//                 decoration: BoxDecoration(
//                     color: widget.buttonColor,
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                 child: TextButton(
//                     onPressed: () {},
//                     child:
//                         Text('1', style: TextStyle(color: widget.textColor))),
//               ),
//               Container(
//                 width: 41,
//                 height: 54,
//                 decoration: BoxDecoration(
//                     color: widget.buttonColor,
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                 child: TextButton(
//                     onPressed: () {},
//                     child:
//                         Text('2', style: TextStyle(color: widget.textColor))),
//               ),
//               Container(
//                 width: 41,
//                 height: 54,
//                 decoration: BoxDecoration(
//                     color: widget.buttonColor,
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                 child: TextButton(
//                     onPressed: () {},
//                     child:
//                         Text('3', style: TextStyle(color: widget.textColor))),
//               ),
//               Container(
//                 width: 41,
//                 height: 54,
//                 decoration: BoxDecoration(
//                     color: widget.buttonColor,
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                 child: TextButton(
//                     onPressed: () {},
//                     child:
//                         Text('4', style: TextStyle(color: widget.textColor))),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
