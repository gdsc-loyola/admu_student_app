// modified from the original ExpansionTile

// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class OfficeDropDown extends StatefulWidget {
  const OfficeDropDown(
    this.data,
    this.onSelect,
  );

  final List<Map<String, dynamic>> data;
  final Function(int) onSelect;

  @override
  _OfficeDropDownState createState() => _OfficeDropDownState();
}

class _OfficeDropDownState extends State<OfficeDropDown>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;

  bool _isExpanded = false;

  int _sel = -1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [AppEffects.SHADOW_FOR_WHITE],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: _handleTap,
            child: Container(
              height: 64, // original 66
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.PRIMARY_MAIN,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _sel == -1
                            ? 'Select an office or a department'
                            : widget.data[_sel]['title'],
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: AppColors.GRAY_LIGHT[2]),
                      ),
                    ),
                    RotationTransition(
                      turns: _iconTurns,
                      child: Icon(
                        Icons.expand_more_rounded,
                        size: 36,
                        color: AppColors.GRAY_LIGHT[2],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ClipRect(
            child: Align(
              alignment: Alignment.center,
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDropDown() {
    List<Widget> widgets = [];

    for (int i = 0; i < widget.data.length; i++) {
      widgets.add(InkWell(
        onTap: () {
          setState(() {
            _sel = i;
            widget.onSelect(_sel);
          });
        },
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Row(children: [
              Expanded(
                child: Text(widget.data[i]['title'],
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.GRAY_DARK[0])),
              )
            ]),
          ),
        ),
      ));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed;

    final Widget result = Offstage(
        child: TickerMode(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildDropDown(),
          ),
          enabled: !closed,
        ),
        offstage: closed);

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}
