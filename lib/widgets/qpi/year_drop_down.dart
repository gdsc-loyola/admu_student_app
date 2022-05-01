import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/_all_courses.dart';
import 'package:admu_student_app/models/_semester.dart';
import 'package:admu_student_app/models/_year.dart';
import 'package:admu_student_app/screens/qpi/add_qpi.dart';
import 'package:admu_student_app/screens/qpi/qpi_semester.dart';

// modified from the original ExpansionTile
const Duration _kExpand = Duration(milliseconds: 200);

class YearDropDown extends StatefulWidget {
  const YearDropDown({
    Key key,
    @required this.yearNum,
  }) : super(key: key);

  final int yearNum;

  @override
  _YearDropDownState createState() => _YearDropDownState();
}

class _YearDropDownState extends State<YearDropDown>
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

  void _onSemesterTap(Semester s) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) =>
              SemesterPage(yearNum: widget.yearNum, semNum: s.semNum)),
    );
  }

  Widget _buildHeader(BuildContext context, Year year) {
    Widget header = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [AppEffects.SHADOW_FOR_WHITE],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      height: 64,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                year.yearString,
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color: AppColors.GRAY_DARK[0], fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: _SmallQPIView(qpi: year.yearlyQPI),
            ),
            year.isYearlyQPI
                ? InkWell(
                    child: Icon(
                      Icons.more_vert,
                      color: AppColors.GRAY_DARK[2],
                      size: 36,
                    ),
                    onTap: () {
                      // edit year
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => AddQPIPage(
                          yearNum: year.yearNum,
                          year: year,
                          isEditing: true,
                          selected: 0,
                        ),
                      ));
                    },
                  )
                : RotationTransition(
                    turns: _iconTurns,
                    child: Icon(
                      Icons.expand_more_rounded,
                      size: 36,
                      color: AppColors.GRAY_DARK[2],
                    ),
                  ),
          ],
        ),
      ),
    );

    if (year.isYearlyQPI)
      return header;
    else
      return InkWell(
        onTap: _handleTap,
        child: header,
      );
  }

  Widget _buildSemesters(BuildContext context, Year year) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: year.sems.length,
      itemBuilder: (_, index) {
        Widget semCard = Container(
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.only(right: 16),
          height: 56, // original 55
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
            boxShadow: [AppEffects.SHADOW],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // line
              Container(
                decoration: BoxDecoration(
                  color: AppColors.SECONDARY_MAIN,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                width: 10,
                height: 56,
                margin: EdgeInsets.only(right: 16),
              ),

              // text
              Expanded(
                child: Text(
                  year.sems[index].semString,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: AppColors.GRAY_DARK[0],
                      fontWeight: FontWeight.w500),
                ),
              ),

              // qpi
              _SmallQPIView(
                qpi: year.sems[index].semestralQPI,
                showBackground: false,
                reverseColor: true,
              ),

              // icon
              InkWell(
                child: Icon(
                  year.sems[index].isSemestralQPI
                      ? Icons.more_vert
                      : Icons.chevron_right_rounded,
                  color: AppColors.GRAY_DARK[2],
                  size: 36.0,
                ),
                onTap: () {
                  if (year.sems[index].isSemestralQPI)
                    // edit sem
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AddQPIPage(
                          yearNum: year.yearNum,
                          semNum: year.sems[index].semNum,
                          semester: year.sems[index],
                          isEditing: true,
                          selected: 1,
                        ),
                      ),
                    );
                  else
                    _onSemesterTap(year.sems[index]);
                },
              ),
            ],
          ),
        );

        if (year.sems[index].isSemestralQPI)
          return semCard;
        else
          return InkWell(
            onTap: () => _onSemesterTap(year.sems[index]),
            child: semCard,
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

    Year year =
        Provider.of<AllCourses>(context, listen: false).getYear(widget.yearNum);

    final Widget result = Offstage(
        child: TickerMode(
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: _buildSemesters(context, year),
          ),
          enabled: !closed,
        ),
        offstage: closed);

    return Column(
      children: [
        _buildHeader(context, year),
        AnimatedBuilder(
          animation: _controller.view,
          builder: _buildChildren,
          child: shouldRemoveChildren ? null : result,
        ),
      ],
    );
  }
}

class _SmallQPIView extends StatelessWidget {
  final bool showBackground;
  final bool reverseColor;
  final double qpi;

  _SmallQPIView({
    @required this.qpi,
    this.showBackground = true,
    this.reverseColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: showBackground ? AppColors.PRIMARY_ALT : Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      width: 75,
      height: 32,
      child: Center(
        child: Text(
          '${qpi.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.headline6.copyWith(
              color: reverseColor
                  ? AppColors.GRAY_DARK[1]
                  : AppColors.GRAY_LIGHT[2],
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
