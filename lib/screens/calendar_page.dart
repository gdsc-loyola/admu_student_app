import 'package:flutter/material.dart';

import 'package:admu_student_app/widgets/drawer_widget.dart';


class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
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
            //Navigate to AddEventPage
          }, icon: Icon(Icons.add_rounded))
        ],
      ),

      drawer: DrawerWidget(),
      body: Container(
        child: Text('This is the Calendar Page'),
      ),
    );
  }
}
