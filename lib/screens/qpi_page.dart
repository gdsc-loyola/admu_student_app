import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:admu_student_app/models/year.dart';
import 'package:admu_student_app/widgets/drawer_widget.dart';
import 'package:admu_student_app/widgets/qpi/year_drop_down.dart';



class QPIPage extends StatefulWidget {
  @override
  _QPIPageState createState() => _QPIPageState();
}

class _QPIPageState extends State<QPIPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          //The property and builder changes the DrawerWidget's icon to customize
          automaticallyImplyLeading: false,
          title: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu_rounded),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),

          actions: [
            IconButton(onPressed: (){
              //Navigate to AddQPIPage
            }, icon: Icon(Icons.add_rounded))
          ],
        ),

      drawer: DrawerWidget(),
      body: YearDropDown()
    );
  }
}

