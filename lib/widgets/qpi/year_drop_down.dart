import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/academic_records.dart';
import 'package:admu_student_app/models/semester.dart';
import 'package:admu_student_app/models/year.dart';
import 'package:admu_student_app/screens/qpi/add_qpi.dart';
import 'package:admu_student_app/screens/qpi/qpi_semester.dart';

class YearDropDown extends StatefulWidget {
  final int yearNum;

  YearDropDown({@required this.yearNum});

  @override
  _YearDropDownState createState() => _YearDropDownState();
}

class _YearDropDownState extends State<YearDropDown> {
  bool _isExpanded = false;

  void _onHeaderTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _onSemesterTap(Semester s) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SemesterPage(yearNum: widget.yearNum, semNum: s.semNum)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Year year = Provider.of<AcademicRecords>(context, listen: false)
        .getYear(widget.yearNum);

    // if (year.isYearlyQPI)
    //   return ExpansionTile(
    //     backgroundColor: Colors.white,
    //     collapsedBackgroundColor: Colors.white,
    //     tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
    //     title: Row(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Expanded(
    //           child: Text(
    //             year.yearString,
    //             style: Theme.of(context).textTheme.headline6.copyWith(
    //                 color: AppColors.GRAY_DARK[0], fontWeight: FontWeight.w500),
    //           ),
    //         ),
    //         _YearQPIView(qpi: year.yearlyQPI),
    //       ],
    //     ),
    //     children: [
    //       ListView.builder(
    //         physics: NeverScrollableScrollPhysics(),
    //         shrinkWrap: true,
    //         itemCount: year.sems.length,
    //         itemBuilder: (_, index) {
    //           return Container(
    //             margin: EdgeInsets.only(left: 16.0, top: 16.0),
    //             padding: EdgeInsets.symmetric(horizontal: 16.0),
    //             height: 56, // original 55
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.all(Radius.circular(8)),
    //               color: AppColors.PRIMARY_LIGHT,
    //               boxShadow: [AppEffects.SHADOW],
    //             ),
    //             child: Row(
    //               children: [
    //                 Expanded(
    //                   child: Text(
    //                     year.sems[index].semString,
    //                     style: Theme.of(context).textTheme.bodyText1.copyWith(
    //                         color: AppColors.GRAY_LIGHT[2],
    //                         fontWeight: FontWeight.w500),
    //                   ),
    //                 ),
    //                 IconButton(
    //                   icon: Icon(
    //                     Icons.arrow_forward_ios_rounded,
    //                     size: 36.0,
    //                     color: AppColors.GRAY_LIGHT[0],
    //                   ),
    //                   onPressed: () {
    //                     Navigator.of(context).push(MaterialPageRoute(
    //                       builder: (_) => SemesterPage(sem: year.sems[index]),
    //                     ));
    //                   },
    //                 ),
    //               ],
    //             ),
    //           );
    //         },
    //       ),
    //     ],
    //   );
    // else
    //   return Container(
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.all(Radius.circular(8)),
    //       boxShadow: [AppEffects.SHADOW],
    //     ),
    //     padding: EdgeInsets.symmetric(horizontal: 16.0),
    //     height: 64,
    //     child: Center(
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Expanded(
    //             child: Text(
    //               year.yearString,
    //               style: Theme.of(context).textTheme.headline6.copyWith(
    //                   color: AppColors.GRAY_DARK[0], fontWeight: FontWeight.w500),
    //             ),
    //           ),
    //           _YearQPIView(qpi: year.yearlyQPI),
    //           IconButton(
    //             icon: Icon(
    //               Icons.more_vert,
    //               size: 36.0,
    //               color: AppColors.GRAY_LIGHT[0],
    //             ),
    //             onPressed: () {
    //               Navigator.of(context).push(MaterialPageRoute(
    //                 builder: (_) => AddQPIPage(),
    //               ));
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   );

    Widget header = Container(
      decoration: BoxDecoration(
        color: Colors.white, // should be AppColors.GRAY_LIGHT[1]
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [AppEffects.SHADOW],
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
            IconButton(
              icon: Icon(
                year.isYearlyQPI
                    ? Icons.more_vert
                    : (_isExpanded
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded),
                color: AppColors.GRAY_DARK[2],
              ),
              iconSize: 36.0,
              onPressed: () {
                if (year.isYearlyQPI)
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => AddQPIPage(),
                  ));
                else
                  _onHeaderTap();
              },
            ),
          ],
        ),
      ),
    );
    Widget children = ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: year.sems.length,
      itemBuilder: (_, index) {
        Widget semCard = Row(
          children: [
            Expanded(
              child: Text(
                year.sems[index].semString,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: AppColors.GRAY_LIGHT[2],
                    fontWeight: FontWeight.w500),
              ),
            ),
            _SmallQPIView(
              qpi: year.sems[index].semestralQPI,
              showBackground: false,
            ),
            IconButton(
              icon: Icon(
                year.sems[index].isSemestralQPI
                    ? Icons.more_vert
                    : Icons.chevron_right_rounded,
                color: AppColors.GRAY_LIGHT[0],
              ),
              iconSize: 36.0,
              onPressed: () {
                if (year.sems[index].isSemestralQPI)
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AddQPIPage(),
                    ),
                  );
                else
                  _onSemesterTap(year.sems[index]);
              },
            ),
          ],
        );

        return Container(
          margin: EdgeInsets.only(left: 16.0, top: 16.0),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          height: 56, // original 55
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppColors.PRIMARY_ALT,
            boxShadow: [AppEffects.SHADOW],
          ),
          child: year.sems[index].isSemestralQPI
              ? semCard
              : GestureDetector(
                  onTap: () => _onSemesterTap(year.sems[index]),
                  child: semCard,
                ),
        );
      },
    );

    // basic widget, no animation
    return Column(
      children: [
        year.isYearlyQPI
            ? header
            : GestureDetector(
                onTap: _onHeaderTap,
                child: header,
              ),
        _isExpanded ? children : Container(),
      ],
    );
  }
}

class _SmallQPIView extends StatelessWidget {
  final bool showBackground;
  final double qpi;

  _SmallQPIView({@required this.qpi, this.showBackground = true});

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
              color: AppColors.GRAY_LIGHT[2], fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
