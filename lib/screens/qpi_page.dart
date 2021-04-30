import 'package:admu_student_app/models/year.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QPIPage extends StatefulWidget {
  @override
  _QPIPageState createState() => _QPIPageState();
}

class _QPIPageState extends State<QPIPage> {
  List<YearDropDown> _years = <YearDropDown>[
    YearDropDown(
        header: "Year 1",
        body: "FIRST SEMESTER"
    ),

    YearDropDown(
        header: "Year 2",
        body: "FIRST SEMESTER"
    ),

    YearDropDown(
        header: "Year 3",
        body: "FIRST SEMESTER"
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded){
              setState(() {
                _years[index].isExpanded = !_years[index].isExpanded;
              });
            },

            children:
            _years.map((YearDropDown year){
              return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded){
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Text(
                          year.header,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                            ),
                          ),
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
                          year.body,
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

                      ExpansionTile(
                        title: Text(
                          year.body,
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


class YearDropDown{
  YearDropDown({this.isExpanded: false, this.header, this.body});

  bool isExpanded;
  final String header;
  final String body;

}