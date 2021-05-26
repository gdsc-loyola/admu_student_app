import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/add_qpi_notifier.dart';

class SelectColor extends StatefulWidget {
  final Color color;
  final Function(Color) onColorChange;

  SelectColor({this.color, this.onColorChange});

  @override
  _SelectColorState createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  int _selected = -1;

  Color _color;

  @override
  void initState() {
    super.initState();

    /*if (Provider.of<AddQPINotifier>(context, listen: false).hasOldColor) {
      Color c = Provider.of<AddQPINotifier>(context, listen: false).color;
      for (int i = 0; i < AppColors.ACCENTS.length; i++) {
        if (c.value == AppColors.ACCENTS[i].value) {
          _selected = i;
          break;
        }
      }

      if (_selected == -1) _selected = 5;
    }*/

    // new
    if (widget.color != null) {
      _color = widget.color;

      for (int i = 0; i < AppColors.ACCENTS.length; i++) {
        if (_color.value == AppColors.ACCENTS[i].value) {
          _selected = i;
          break;
        }
      }

      if (_selected == -1) _selected = 5;
    }
  }

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

      // Provider.of<AddQPINotifier>(context, listen: false).color = color;

      // new
      _color = color;
      if (widget.onColorChange != null) widget.onColorChange(_color);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool shouldShrink =
        MediaQuery.of(context).size.width - 16 * 2 < 56 * 6 + 8 * 5;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _CustomIcon(
          isSelected: _selected == 0,
          bgColor: AppColors.ACCENTS[0],
          shrink: shouldShrink,
          onTap: () => _onSelect(context, 0),
        ),
        SizedBox(width: 8),
        _CustomIcon(
          isSelected: _selected == 1,
          bgColor: AppColors.ACCENTS[1],
          shrink: shouldShrink,
          onTap: () => _onSelect(context, 1),
        ),
        SizedBox(width: 8),
        _CustomIcon(
          isSelected: _selected == 2,
          bgColor: AppColors.ACCENTS[2],
          shrink: shouldShrink,
          onTap: () => _onSelect(context, 2),
        ),
        SizedBox(width: 8),
        _CustomIcon(
          isSelected: _selected == 3,
          bgColor: AppColors.ACCENTS[3],
          shrink: shouldShrink,
          onTap: () => _onSelect(context, 3),
        ),
        SizedBox(width: 8),
        _CustomIcon(
          isSelected: _selected == 4,
          bgColor: AppColors.ACCENTS[4],
          shrink: shouldShrink,
          onTap: () => _onSelect(context, 4),
        ),
        SizedBox(width: 8),
        _CustomIcon(
          icon: Icon(
            Icons.add_rounded,
            color: AppColors.GRAY_LIGHT[0],
            size: 36,
          ),
          isSelected: _selected == 5,
          bgColor: _selected == 5
              ? Colors.blue // Provider.of<AddQPINotifier>(context).color
              : AppColors.GRAY_LIGHT[2],
          shrink: shouldShrink,
          onTap: () => _onSelect(context, 5),
        ),
      ],
    );
  }
}

class _CustomIcon extends StatefulWidget {
  final Icon icon;
  final bool isSelected;
  final Color bgColor;
  final bool shrink;
  final VoidCallback onTap;

  const _CustomIcon({
    Key key,
    this.icon,
    this.isSelected = false,
    this.bgColor = Colors.white,
    this.shrink = true,
    this.onTap,
  }) : super(key: key);
  @override
  _CustomIconState createState() => _CustomIconState();
}

class _CustomIconState extends State<_CustomIcon> {
  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      width: widget.shrink ? null : 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(7)),
        color: AppColors.GRAY_LIGHT[2],
      ),
      child: Center(
        child: Container(
          margin: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: widget.icon == null ? Container() : widget.icon,
          ),
        ),
      ),
    );

    Widget iconButton;

    if (widget.isSelected) {
      Widget full = Stack(
        children: [
          child,
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(7),
                    bottomRight: Radius.circular(7),
                  ),
                  color: AppColors.GRAY_LIGHT[2],
                ),
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
          ),
        ],
      );

      if (widget.shrink)
        return Expanded(
          child: InkWell(
            onTap: () {
              if (widget.onTap != null) widget.onTap();
            },
            child: full,
          ),
        );
      else
        iconButton = full;
    } else {
      if (widget.shrink)
        return Expanded(
          child: InkWell(
            onTap: () {
              if (widget.onTap != null) widget.onTap();
            },
            child: child,
          ),
        );
      else
        iconButton = child;
    }

    return InkWell(
      onTap: () {
        if (widget.onTap != null) widget.onTap();
      },
      child: Ink(child: iconButton),
    );
  }
}
