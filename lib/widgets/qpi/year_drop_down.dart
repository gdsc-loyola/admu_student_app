import 'package:admu_student_app/models/year.dart';
import 'package:admu_student_app/screens/qpi/qpi_semester.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YearDropDown extends StatefulWidget {
  @override
  _YearDropDownState createState() => _YearDropDownState();
}

class _YearDropDownState extends State<YearDropDown> {
  List<YearExpansionPanel> _years = <YearExpansionPanel>[
    YearExpansionPanel(
      header: "Year 1",
        body1: "First Semester",
        body2: "Second Semester"
    ),

    YearExpansionPanel(
      header: "Year 2",
        body1: "First Semester",
        body2: "Second Semester"
    ),

    YearExpansionPanel(
      header: "Year 3",
        body1: "First Semester",
        body2: "Second Semester"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded){
              setState(() {
                _years[index].isExpanded = !_years[index].isExpanded;
              });
            },

            children:
            _years.map((YearExpansionPanel year){
              return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded){
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Text(
                          year.header,
                          style: Theme.of(context).textTheme.headline6
                        ),
                      ),
                    );
                  },
                  isExpanded: year.isExpanded,

                  //BODY OF DROPDOWN WIDGET
                  body: Column(
                    children: [
                      ExpansionTile(
                        title: Text(
                          year.body1,
                        ),
                        trailing: IconButton(
                          iconSize: 17,
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SemesterPage(yearNum: 1, semNum: 1)),
                            );
                          },
                        ),
                      ),

                      ExpansionTile(
                        title: Text(
                          year.body2  ,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 17,
                          ),
                          onPressed: (){
                            //NAVIGATE TO NEW PAGE
                          },
                        ),
                      ),
                    ],

                  )
              );
            }).toList(),
          )
        ],
        //basicTiles.map((tile) => BasicTileWidget(tile: tile)).toList(),
      ),
    );
  }
}

class YearExpansionPanel{
  YearExpansionPanel({this.isExpanded: false, this.header, this.body1, this.body2});

  bool isExpanded;
  final String header;
  final String body1, body2;

}