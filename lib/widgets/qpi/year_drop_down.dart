import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/academic_records.dart';
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

    // basic widget, no animation
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
                        color: AppColors.GRAY_DARK[0],
                        fontWeight: FontWeight.w500),
                  ),
                ),
                _YearQPIView(qpi: year.yearlyQPI),
                IconButton(
                  icon: Icon(
                    year.isYearlyQPI
                        ? (_isExpanded
                            ? Icons.expand_less_rounded
                            : Icons.expand_more_rounded)
                        : Icons.more_vert,
                    color: AppColors.GRAY_LIGHT[0],
                  ),
                  iconSize: 32.0,
                  onPressed: () {
                    if (year.isYearlyQPI)
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    else
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => AddQPIPage(),
                      ));
                  },
                ),
              ],
            ),
          ),
        ),
        _isExpanded
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: year.sems.length,
                itemBuilder: (_, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 16.0, top: 16.0),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    height: 56, // original 55
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: AppColors.PRIMARY_MAIN,
                      boxShadow: [AppEffects.SHADOW],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            year.sems[index].semString,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    color: AppColors.GRAY_LIGHT[2],
                                    fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          '${year.sems[index].semestralQPI.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: AppColors.GRAY_LIGHT[2],
                              fontWeight: FontWeight.w500),
                        ),
                        IconButton(
                          icon: Icon(
                            year.isYearlyQPI
                                ? Icons.more_vert
                                : Icons.arrow_forward_ios_rounded,
                            color: AppColors.GRAY_LIGHT[0],
                          ),
                          iconSize: 24.0,
                          onPressed: () {
                            if (year.sems[index].isSemestralQPI)
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => AddQPIPage(),
                                ),
                              );
                            else
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) =>
                                        SemesterPage(sem: year.sems[index])),
                              );
                          },
                        ),
                      ],
                    ),
                  );
                },
              )
            : Container(),
      ],
    );
  }
}

class _YearQPIView extends StatelessWidget {
  final double qpi;

  _YearQPIView({@required this.qpi});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.PRIMARY_LIGHT,
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
