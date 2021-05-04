import 'package:flutter/material.dart';

class SelectColor extends StatefulWidget {
  @override
  _SelectColorState createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  List<bool> colorSelected = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToggleButtons(
          children: [
            CustomIcon(
              isSelected: colorSelected[0],
              bgColor: const Color(0xffFF8591),
            ),
            CustomIcon(
              isSelected: colorSelected[1],
              bgColor: const Color(0xffFFE0A5),
            ),
            CustomIcon(
              isSelected: colorSelected[2],
              bgColor: const Color(0xffA0E7D5),
            ),
            CustomIcon(
              isSelected: colorSelected[3],
              bgColor: const Color(0xff86CCFF),
            ),
            CustomIcon(
              isSelected: colorSelected[4],
              bgColor: const Color(0xffB99FFF),
            ),
            CustomIcon(
              icon: const Icon(Icons.add_rounded, color: Colors.grey, size: 40),
              isSelected: colorSelected[5],
              bgColor: Colors.white,
            ),
          ],
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
              buttonIndex < colorSelected.length;
              buttonIndex++) {
                if (buttonIndex == index) {
                  colorSelected[buttonIndex] = !colorSelected[buttonIndex];
                } else {
                  colorSelected[buttonIndex] = false;
                }
              }
            });
          },
          isSelected: colorSelected,
          renderBorder: false,
          fillColor: Colors.transparent,
        ),
      ],
    );
  }
}

class CustomIcon extends StatefulWidget {
  final Icon icon;
  final bool isSelected;
  final Color bgColor;

  const CustomIcon(
      {Key key,
        this.icon,
        this.isSelected = false,
        this.bgColor,
      })
      : super(key: key);
  @override
  _CustomIconState createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              border: widget.isSelected
                  ? Border.all(
                width: 2,
                color: Colors.grey,
              )
                  : Border.all(
                width: 2,
                color: Colors.white,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(7),
              ),
            ),
            child: Center(
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: widget.bgColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: widget.icon,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
