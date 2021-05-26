import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';

// modified from the original ExpansionTile
const Duration _kExpand = Duration(milliseconds: 200);

class EnlistmentClassCard extends StatefulWidget {
  const EnlistmentClassCard({
    Key key,
    // @required this.yearNum,
  }) : super(key: key);

  // final int yearNum;

  @override
  _EnlistmentClassCardState createState() => _EnlistmentClassCardState();
}

class _EnlistmentClassCardState extends State<EnlistmentClassCard>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;

  bool _isExpanded = false;

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

  Widget _buildHeader(BuildContext context) {
    Widget header = Container(
      decoration: BoxDecoration(
        color: AppColors.GRAY_LIGHT[2],
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [AppEffects.SHADOW],
      ),
      height: 72,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // line
          Container(
            margin: EdgeInsets.only(right: 22),
            decoration: BoxDecoration(
              color: AppColors.ACCENTS[0],
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            width: 10,
            height: 72, // from 64
          ),
          // text, units, prof
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // text
              Text('COURSE 101',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: AppColors.GRAY)),
              // units and prof
              Row(
                children: [
                  // units
                  Container(
                    width: 64,
                    height: 19,
                    decoration: BoxDecoration(
                        color: AppColors.ACCENTS[0].withOpacity(0.25),
                        borderRadius: BorderRadius.all(
                            Radius.circular(4))), // original 3.55
                    child: Center(
                      child: Text(
                        '3 Units',
                        style: Theme.of(context).textTheme.caption.copyWith(
                            color: AppColors.ACCENTS[0],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // prof
                  Container(
                    width: 64,
                    height: 19,
                    decoration: BoxDecoration(
                        color: AppColors.ACCENTS[0].withOpacity(0.25),
                        borderRadius: BorderRadius.all(
                            Radius.circular(4))), // original 3.55
                    child: Center(
                      child: Text(
                        '3 Units',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption.copyWith(
                            color: AppColors.ACCENTS[0],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          // button edit
          RotationTransition(
            turns: _iconTurns,
            child: Icon(
              Icons.expand_more_rounded,
              size: 36,
              color: AppColors.GRAY_DARK[2],
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: _handleTap,
      child: header,
    );
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return ClipRect(
      child: Align(
        alignment: Alignment.center,
        heightFactor: _heightFactor.value,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed;

    final Widget result = Offstage(
        child: TickerMode(
          child: Container(), // should contain children
          enabled: !closed,
        ),
        offstage: closed);

    return Column(
      children: [
        _buildHeader(context),
        AnimatedBuilder(
          animation: _controller.view,
          builder: _buildChildren,
          child: shouldRemoveChildren ? null : result,
        ),
      ],
    );
  }
}
