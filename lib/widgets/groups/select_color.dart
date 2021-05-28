import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/widgets/buttons.dart';

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
    if (index == 5) {
      await showGeneralDialog(
        context: context,
        pageBuilder: (context, _, __) {
          Color newColor = Colors.blue;

          return Center(
            child: Column(
              children: [
                MaterialPicker(
                  pickerColor: newColor,
                  onColorChanged: (Color c) {
                    newColor = c;
                  },
                ),
                SizedBox(height: 8),
                ShortButton(
                  'Select',
                  AppColors.PRIMARY_MAIN,
                  AppColors.GRAY_LIGHT[2],
                  () {
                    Navigator.of(context).pop();
                  },
                  shadows: [AppEffects.SHADOW],
                ),
                SizedBox(height: 16),
                ShortButton(
                  'Cancel',
                  AppColors.GRAY_DARK[2],
                  AppColors.GRAY_DARK[0],
                  () {
                    setState(() {
                      _selected = index;

                      _color = newColor;
                    });
                  },
                ),
              ],
            ),
          );
        },
      );
    } else {
      setState(() {
        _selected = index;

        _color = AppColors.ACCENTS[index];
        if (widget.onColorChange != null) widget.onColorChange(_color);
      });
    }
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
              ? Colors.blue // temporary
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
