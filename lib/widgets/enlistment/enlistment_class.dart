import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/subject.dart';
import 'package:admu_student_app/widgets/circular_check_mark.dart';

// modified from the original ExpansionTile
const Duration _kExpand = Duration(milliseconds: 200);

class EnlistmentClassCard extends StatefulWidget {
  final String code;
  final List<Subject> subjects;
  final bool isSelecting;
  final Function(int) onSelect;

  const EnlistmentClassCard({
    Key key,
    @required this.code,
    @required this.subjects,
    this.isSelecting = false,
    this.onSelect,
  }) : super(key: key);

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

  String _getScheduleString(Subject s) {
    String str = '';

    final List<String> days = ['M', 'T', 'W', 'Th', 'F', 'S'];

    for (int i = 0; i < s.days.length; i++) {
      if (s.days[i]) str += days[i];
    }

    return str;
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
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [AppEffects.SHADOW_FOR_WHITE],
      ),
      height: 72,
      padding: EdgeInsets.only(left: 24, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // course code, group
          Expanded(
            child: Text(widget.code,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: AppColors.GRAY_DARK[0])),
          ),
          SizedBox(width: 8), // temporary padding

          RotationTransition(
            turns: _iconTurns,
            child: Icon(
              Icons.expand_more_rounded,
              size: 36,
              color: AppColors.GRAY_LIGHT[0],
            ),
          ),
        ],
      ),
    );

    return InkWell(
      onTap: _handleTap,
      child: header,
    );
  }

  Widget _buildCards() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.subjects.length,
      itemBuilder: (_, index) {
        Widget card = Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [AppEffects.SHADOW_FOR_WHITE],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // line
              Container(
                decoration: BoxDecoration(
                  color: widget.subjects[index].color,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                width: 10,
                height: 72,
                margin: EdgeInsets.only(right: 22),
              ),

              // column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // prof name
                  Text(
                    widget.subjects[index].profName,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: AppColors.GRAY),
                  ),
                  SizedBox(height: 4),

                  // tags
                  Row(
                    children: [
                      // section
                      Container(
                        decoration: BoxDecoration(
                          color: widget.subjects[index].color.withOpacity(0.25),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16), // temp
                        child: Center(
                          child: Text(
                              'Section ${widget.subjects[index].section}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      color: widget.subjects[index].color)),
                        ),
                      ),
                      SizedBox(width: 8),

                      // days
                      Container(
                        decoration: BoxDecoration(
                          color: widget.subjects[index].color.withOpacity(0.25),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16), // temp
                        child: Center(
                          child: Text(
                              _getScheduleString(widget.subjects[index]),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      color: widget.subjects[index].color)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(), // temp?

              // time
              Text(
                '${widget.subjects[index].getReadableStartTime()}\n${widget.subjects[index].getReadableEndTime()}',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: AppColors.GRAY_DARK[2]),
              ),

              // edit
              IconButton(
                icon: Icon(
                  Icons.more_vert_rounded,
                ),
                iconSize: 36,
                color: AppColors.GRAY_LIGHT[0],
                onPressed: () {
                  print('edit');
                },
              ),
            ],
          ),
        );

        return Padding(
          padding: EdgeInsets.only(top: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isSelecting)
                CircularCheckMark(
                    isDone: false,
                    onTap: () {
                      if (widget.onSelect != null) widget.onSelect(index);
                    }),

              // card
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: widget.isSelecting ? 10 : 46),
                  child: card,
                ),
              ),
            ],
          ),
        );
      },
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
          child: _buildCards(), // should contain children
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
