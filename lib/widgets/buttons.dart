import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/add_qpi_notifier.dart';

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

// used in date and sem buttons
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

// used in quarter?
class ShrinkingButton extends StatelessWidget {
  final String text;
  final double maxWidth;
  final VoidCallback onPressed;
  final bool selected;

  ShrinkingButton({
    this.text = '',
    this.maxWidth = 56,
    this.onPressed,
    this.selected,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 41, // temporary?
      // constraints: BoxConstraints(maxWidth: maxWidth, minWidth: 16),
      height: 56,
      width: double.infinity,
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

    /*return Expanded(
      child: Align(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: SquareButton(
            text: text,
            onPressed: onPressed,
            selected: selected,
          ),
        ),
      ),
    );*/
  }
}

/*
                Expanded(
                  child: Align(child: Container(child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 216),
                    child: Container(
                      width: 128,
                      height: 64,
                      color: Colors.blue,
                    ),
                  ),),),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Align(child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 216),
                    child: Container(
                      height: 64,
                      color: Colors.red,
                    ),
                  ),),
                ),
*/

class GradeDropDown extends StatefulWidget {
  @override
  _GradeDropDownState createState() => _GradeDropDownState();
}

class _GradeDropDownState extends State<GradeDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 185,
      width: double.infinity,
      height: 56,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            value: Provider.of<AddQPINotifier>(context).gradeVal,
            items: [
              DropdownMenuItem(child: Text("A"), value: 1),
              DropdownMenuItem(child: Text("B+"), value: 2),
              DropdownMenuItem(child: Text("B"), value: 3),
              DropdownMenuItem(child: Text("C+"), value: 4),
              DropdownMenuItem(child: Text("C"), value: 5),
              DropdownMenuItem(child: Text("D"), value: 6),
              DropdownMenuItem(child: Text("F/W"), value: 7)
            ],
            onChanged: (value) {
              Provider.of<AddQPINotifier>(context, listen: false).gradeVal =
                  value;
            }),
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
