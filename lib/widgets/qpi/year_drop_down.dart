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
  // List<YearExpansionPanel> _years = <YearExpansionPanel>[
  //   YearExpansionPanel(
  //       header: "Year 1", body1: "FIRST SEMESTER", body2: "SECOND SEMESTER"),
  //   YearExpansionPanel(
  //       header: "Year 2", body1: "FIRST SEMESTER", body2: "SECOND SEMESTER"),
  //   YearExpansionPanel(
  //       header: "Year 3", body1: "FIRST SEMESTER", body2: "SECOND SEMESTER"),
  // ];

  @override
  Widget build(BuildContext context) {
    Year year = Provider.of<AcademicRecords>(context, listen: false)
        .getYear(widget.yearNum);

    if (year.isYearlyQPI)
      return ExpansionTile(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                year.yearString,
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color: AppColors.GRAY_DARK[0], fontWeight: FontWeight.w500),
              ),
            ),
            _YearQPIView(qpi: year.yearlyQPI),
          ],
        ),
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: year.sems.length,
            itemBuilder: (_, index) {
              return Container(
                margin: EdgeInsets.only(left: 16.0, top: 16.0),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                height: 56, // original 55
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: AppColors.PRIMARY_LIGHT,
                  boxShadow: [AppEffects.SHADOW],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        year.sems[index].semString,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: AppColors.GRAY_LIGHT[2],
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 36.0,
                        color: AppColors.GRAY_LIGHT[0],
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => SemesterPage(sem: year.sems[index]),
                        ));
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      );
    else
      return Container(
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
                      color: AppColors.GRAY_DARK[0], fontWeight: FontWeight.w500),
                ),
              ),
              _YearQPIView(qpi: year.yearlyQPI),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  size: 36.0,
                  color: AppColors.GRAY_LIGHT[0],
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => AddQPIPage(),
                  ));
                },
              ),
            ],
          ),
        ),
      );

    // return Container(
    //   child: Column(
    //     children: [
    //       ExpansionPanelList(
    //         expansionCallback: (int index, bool isExpanded) {
    //           setState(() {
    //             _years[index].isExpanded = !_years[index].isExpanded;
    //           });
    //         },
    //         children: _years.map((YearExpansionPanel year) {
    //           return ExpansionPanel(
    //               headerBuilder: (BuildContext context, bool isExpanded) {
    //                 return Padding(
    //                   padding: const EdgeInsets.all(10.0),
    //                   child: ListTile(
    //                     title: Text(
    //                       year.header,
    //                       style: GoogleFonts.dmSans(
    //                         textStyle: TextStyle(
    //                           fontWeight: FontWeight.w500,
    //                           fontSize: 24,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //               },
    //               isExpanded: year.isExpanded,

    //               //BODY OF DROPDOWN WIDGET
    //               body: Column(
    //                 children: [
    //                   ExpansionTile(
    //                     title: Text(
    //                       year.body1,
    //                     ),
    //                     trailing: IconButton(
    //                       icon: Icon(
    //                         Icons.arrow_forward_ios_rounded,
    //                         size: 17,
    //                       ),
    //                       onPressed: () {
    //                         //NAVIGATE TO NEW PAGE
    //                       },
    //                     ),
    //                   ),
    //                   ExpansionTile(
    //                     title: Text(
    //                       year.body2,
    //                     ),
    //                     trailing: IconButton(
    //                       icon: Icon(
    //                         Icons.arrow_forward_ios_rounded,
    //                         size: 17,
    //                       ),
    //                       onPressed: () {
    //                         //NAVIGATE TO NEW PAGE
    //                       },
    //                     ),
    //                   ),
    //                 ],
    //               ));
    //         }).toList(),
    //       )
    //     ],
    //     //basicTiles.map((tile) => BasicTileWidget(tile: tile)).toList(),
    //   ),
    // );
  }
}

// class YearExpansionPanel {
//   YearExpansionPanel(
//       {this.isExpanded: false, this.header, this.body1, this.body2});

//   bool isExpanded;
//   final String header;
//   final String body1, body2;
// }

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
