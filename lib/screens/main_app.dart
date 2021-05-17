import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/screens/calendar/add_event.dart';
import 'package:admu_student_app/screens/calendar/calendar_page.dart';
import 'package:admu_student_app/screens/home/home_page.dart';
import 'package:admu_student_app/screens/qpi/add_qpi.dart';
import 'package:admu_student_app/screens/qpi/qpi_page.dart';
import 'package:admu_student_app/screens/schedule/add_course.dart';
import 'package:admu_student_app/screens/schedule/schedule_page.dart';
import 'package:admu_student_app/widgets/drawer_widget.dart';

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

  final actionPage = [
    null,
    AddEventPage(),
    AddCoursePage(),
    AddQPIPage(),
  ];

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
        actions: _currentIndex == 0
            ? []
            : [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => actionPage[_currentIndex],
                    ));
                  },
                  icon: Icon(Icons.add_rounded),
                ),
              ],
      ),
      body: tabs[_currentIndex],
      drawer: DrawerWidget(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, //Highlights which page the user is
        selectedFontSize: 16,
        unselectedFontSize: 16,
        type:
            BottomNavigationBarType.fixed, //Shows page name even if unselected
        selectedItemColor: AppColors.PRIMARY_MAIN,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? new Image.asset(
                    "assets/home_clicked.png",
                    height: 36,
                    width: 36,
                  )
                : new Image.asset(
                    "assets/home_unclicked.png",
                    height: 36,
                    width: 36,
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? new Image.asset(
                    "assets/calendar_clicked.png",
                    height: 36,
                    width: 36,
                  )
                : new Image.asset(
                    "assets/calendar_unclicked.png",
                    height: 36,
                    width: 36,
                  ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? new Image.asset(
                    "assets/clock_clicked.png",
                    height: 36,
                    width: 36,
                  )
                : new Image.asset(
                    "assets/clock_unclicked.png",
                    height: 36,
                    width: 36,
                  ),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 3
                ? new Image.asset(
                    "assets/qpi_clicked.png",
                    height: 36,
                    width: 36,
                  )
                : new Image.asset(
                    "assets/qpi_unclicked.png",
                    height: 36,
                    width: 36,
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
