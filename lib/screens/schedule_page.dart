import 'package:admu_student_app/widgets/input_field.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/main.dart';
import 'package:admu_student_app/widgets/drawer_widget.dart';
import 'package:admu_student_app/widgets/select_color.dart';




class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<bool> colorSelected = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            //Navigate to AddQPIPage
          }, icon: Icon(Icons.add_rounded))
        ],
      ),

      drawer: DrawerWidget(),
      body: Container(
        color: PrimaryColor,

        child: Column(
          children: [

            Row(
              children: [
                Container(height: 55,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(padding: EdgeInsets.all(9)),

                Container(
                  width: MediaQuery.of(context).size.width/2.5,
                  child: InputField(
                    isMultiLined: false,
                    length: 8,
                  ),
                ),


                Padding(padding: EdgeInsets.all(8)),

              ],
            ),

            Row(
              children: [
                Container(
                  height: 55,
                ),
              ],
            ),

            SelectColor(),

            Row(
              children: [
                Container(height: 55,),
              ],
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              child: InputField(
                isMultiLined: false,
                length: null,
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width/2.5,
              child: InputField(
                isMultiLined: true,
                length: null,
              ),
            ),

          ],
        ),
      ),
    );
  }
}