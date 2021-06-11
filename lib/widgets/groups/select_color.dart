import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/widgets/buttons.dart';

class SelectColor extends StatefulWidget {
  final String label;

  final Color color;
  final Function(Color) onColorChange;

  SelectColor({
    this.label = 'Color Code',
    this.color,
    this.onColorChange,
  });

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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ColorPicker(
                    color: newColor,
                    onChanged: (Color c) {
                      newColor = c;
                    },
                  ),
                  // MaterialPicker(
                  //   pickerColor: newColor,
                  //   onColorChanged: (Color c) {
                  //     newColor = c;
                  //   },
                  // ),
                  SizedBox(height: 8),
                  CustomButton(
                    ButtonSize.medium, // ?
                    'Save Color',
                    AppColors.PRIMARY_MAIN,
                    AppColors.GRAY_LIGHT[2],
                    () {
                      Navigator.of(context).pop();

                      setState(() {
                        _selected = index;

                        _color = newColor;
                      });
                    },
                    shadows: [AppEffects.SHADOW],
                  ),
                  // SizedBox(height: 16),
                  // CustomButton(
                  //   ButtonSize.medium, // ?
                  //   'Cancel',
                  //   AppColors.GRAY_DARK[2],
                  //   AppColors.GRAY_DARK[0],
                  //   () => Navigator.of(context).pop(),
                  // ),
                ],
              ),
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

    Row row = Row(
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
          bgColor: _selected == 5 ? _color : AppColors.GRAY_LIGHT[2],
          shrink: shouldShrink,
          onTap: () => _onSelect(context, 5),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color Code',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: AppColors.GRAY_LIGHT[2]),
        ),
        SizedBox(height: 8),
        row,
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
        borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: AppColors.GRAY_LIGHT[2],
                ),
                height: 24,
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
