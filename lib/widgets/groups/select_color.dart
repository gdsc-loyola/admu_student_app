import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/add_qpi_notifier.dart';

class SelectColor extends StatefulWidget {
  @override
  _SelectColorState createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  int _selected = -1;
  // List<bool> colorSelected = List.generate(6, (index) => false);

  void _onSelect(BuildContext context, int index) async {
    setState(() {
      _selected = index;

      Color color;

      if (_selected < 5)
        color = AppColors.ACCENTS[index];
      else {
        // open alert dialog
        // showGeneralDialog();

        // get color and return
        // widget.onSelect();
        color = Colors.blue;
      }

      Provider.of<AddQPINotifier>(context, listen: false).color = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: _CustomIcon(
            isSelected: _selected == 0,
            bgColor: AppColors.ACCENTS[0],
          ),
          onTap: () => _onSelect(context, 0),
        ),
        InkWell(
          child: _CustomIcon(
            isSelected: _selected == 1,
            bgColor: AppColors.ACCENTS[1],
          ),
          onTap: () => _onSelect(context, 1),
        ),
        InkWell(
          child: _CustomIcon(
            isSelected: _selected == 2,
            bgColor: AppColors.ACCENTS[2],
          ),
          onTap: () => _onSelect(context, 2),
        ),
        InkWell(
          child: _CustomIcon(
            isSelected: _selected == 3,
            bgColor: AppColors.ACCENTS[3],
          ),
          onTap: () => _onSelect(context, 3),
        ),
        InkWell(
          child: _CustomIcon(
            isSelected: _selected == 4,
            bgColor: AppColors.ACCENTS[4],
          ),
          onTap: () => _onSelect(context, 4),
        ),
        InkWell(
          onTap: () => _onSelect(context, 5),
          child: _CustomIcon(
            icon: Icon(
              Icons.add_rounded,
              color: AppColors.GRAY_LIGHT[0],
              size: 36,
            ),
            isSelected: _selected == 5,
            bgColor: Provider.of<AddQPINotifier>(context).color,
          ),
        ),
      ],
    );

    // this code can be used for day select?
    /*return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );*/
  }
}

class _CustomIcon extends StatefulWidget {
  final Icon icon;
  final bool isSelected;
  final Color bgColor;

  const _CustomIcon({
    Key key,
    this.icon,
    this.isSelected = false,
    this.bgColor = Colors.white,
  }) : super(key: key);
  @override
  _CustomIconState createState() => _CustomIconState();
}

class _CustomIconState extends State<_CustomIcon> {
  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        // border: Border.all(width: 2, color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(7)),
        color: Colors.white,
      ),
      child: Center(
        child: Container(
          width: 54, // original 55x55, to-change
          height: 54,
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: widget.icon,
        ),
      ),
    );

    if (widget.isSelected)
      return Stack(
        children: [
          child,
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                color: Colors.white,
              ),
              width: 56,
              height: 32,
              child: Center(
                child: Icon(
                  Icons.check_rounded,
                  color: AppColors.GRAY_DARK[0],
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      );
    else
      return child;

    /*return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              border: widget.isSelected
                  ? Border.all(width: 2, color: Colors.grey)
                  : Border.all(width: 2, color: Colors.white),
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
    );*/
  }
}
