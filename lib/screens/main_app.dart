import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/screens/calendar/calendar_page.dart';
import 'package:admu_student_app/screens/home/home_page.dart';
import 'package:admu_student_app/screens/qpi/qpi_page.dart';
import 'package:admu_student_app/screens/schedule/schedule_page.dart';

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
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type:
            BottomNavigationBarType.fixed, //Shows page name even if unselected
        selectedItemColor: AppColors.PRIMARY_MAIN,
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
