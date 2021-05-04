import 'package:admu_student_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      ),


      drawer: DrawerWidget(),
      body: Column(
        children: [
        Text('This is the Home Page'),
        ],
      ),
    );
  }
}
