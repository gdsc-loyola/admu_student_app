import 'package:flutter/material.dart';
import 'package:admu_student_app/main.dart';
import 'package:admu_student_app/screens/calendar_page.dart';
import 'package:admu_student_app/screens/home_page.dart';
import 'package:admu_student_app/screens/qpi_page.dart';
import 'package:admu_student_app/screens/schedule_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final tabs = [
    HomePage(),
    CalendarPage(),
    SchedulePage(),
    QPIPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, //Highlights which page the user is
        type: BottomNavigationBarType.fixed, //Shows page name even if unselected
        selectedItemColor: PrimaryColor,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? new Image.asset(
              "assets/home_clicked.png",
              height: 32,
              width: 32,
            )
                : new Image.asset(
              "assets/home_unclicked.png",
              height: 32,
              width: 32,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? new Image.asset(
              "assets/calendar_clicked.png",
              height: 32,
              width: 32,
            )
                : new Image.asset(
              "assets/calendar_unclicked.png",
              height: 32,
              width: 32,
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? new Image.asset(
              "assets/clock_clicked.png",
              height: 32,
              width: 32,
            )
                : new Image.asset(
              "assets/clock_unclicked.png",
              height: 32,
              width: 32,
            ),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 3
                ? new Image.asset(
              "assets/qpi_clicked.png",
              height: 32,
              width: 32,
            )
                : new Image.asset(
              "assets/qpi_unclicked.png",
              height: 32,
              width: 32,
            ),
            label: 'QPI',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),

  );
  }
}