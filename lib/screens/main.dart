import 'package:flutter/material.dart';
import 'package:admu_student_app/widgets/nav_bar.dart';

void main() {
  runApp(MyApp());
}

const PrimaryColor = const Color(0xFF9873FF); //Color of App Bar and Navigation Bar

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: PrimaryColor, //#AB8CFF
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
      ),
      home: NavBar(),
    );
  }
}

