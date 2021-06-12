import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/class_schedule.dart';
import 'package:admu_student_app/models/notification_center.dart';
import 'package:admu_student_app/screens/calendar/calendar_page.dart';
import 'package:admu_student_app/screens/enlistment/enlistment_page.dart';
import 'package:admu_student_app/screens/home/home_page.dart';
import 'package:admu_student_app/screens/home/notifications_page.dart';
import 'package:admu_student_app/screens/qpi/add_qpi.dart';
import 'package:admu_student_app/screens/qpi/qpi_page.dart';
import 'package:admu_student_app/screens/schedule/schedule_page.dart';
import 'package:admu_student_app/screens/add_class.dart';
import 'package:admu_student_app/screens/add_task.dart';
import 'package:admu_student_app/widgets/modals/alert.dart';
import 'package:admu_student_app/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  DateTime _calDate;

  @override
  void initState() {
    super.initState();

    _calDate = DateTime.now();
  }

  Widget _buildBody() {
    if (_currentIndex == 0)
      return HomePage();
    else if (_currentIndex == 1)
      return CalendarPage(
          date: _calDate,
          onDateChange: (DateTime dt) {
            setState(() {
              _calDate = dt;
            });
          });
    else if (_currentIndex == 2)
      return SchedulePage();
    else if (_currentIndex == 3)
      return QPIPage();
    else
      return Container();
  }

  List<Widget> _getAppBarActions() {
    // home
    if (_currentIndex == 0) {
      int numNotifs = Provider.of<NotificationCenter>(context).getNumUnread();

      Widget icon;

      if (numNotifs == 0)
        icon = Icon(Icons.notifications);
      else
        icon = Stack(
          children: [
            Center(child: Icon(Icons.notifications_none_rounded)),
            Align(
              alignment: Alignment.topRight,
              child: SizedOverflowBox(
                size: Size(14, 14),
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.ACCENTS[0],
                  ),
                  width: 18,
                  height: 18,
                  child: Center(
                    child: Text(
                      '$numNotifs',
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.GRAY_LIGHT[2],
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );

      return [
        IconButton(
          icon: icon,
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NotificationsPage())),
          iconSize: 32,
        ),
      ];
    }

    VoidCallback onPressed = () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) {
          if (_currentIndex == 1) {
            if (_calDate.year == DateTime.now().year &&
                _calDate.month == DateTime.now().month &&
                _calDate.day == DateTime.now().day)
              return AddTaskPage(date: DateTime.now());
            else
              return AddTaskPage(date: _calDate);
          } else if (_currentIndex == 2)
            return AddClassPage();
          else if (_currentIndex == 3)
            return AddQPIPage();
          else
            return Container();
        },
      ));
    };

    IconButton addButton = IconButton(
      icon: Icon(Icons.add_rounded),
      onPressed: onPressed,
      iconSize: 32,
    );

    List<Widget> actions = [];

    // cal
    if (_currentIndex == 1) {
      int numUndated =
          Provider.of<CalendarEvents>(context).getUndatedEvents().length;

      Widget icon;

      if (numUndated == 0)
        icon = Icon(Icons.inventory_2_outlined);
      else
        icon = Stack(
          children: [
            Center(child: Icon(Icons.inventory_2_outlined)),
            Align(
              alignment: Alignment.topRight,
              child: SizedOverflowBox(
                size: Size(14, 14),
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.ACCENTS[0],
                  ),
                  width: 18,
                  height: 18,
                  child: Center(
                    child: Text(
                      '$numUndated',
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.GRAY_LIGHT[2],
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );

      actions.add(IconButton(
        icon: icon,
        onPressed: () {}, // push to undated tasks
        iconSize: 32,
      ));
    }

    // sched
    if (_currentIndex == 2) {
      actions.add(IconButton(
        icon: Icon(CupertinoIcons.delete),
        onPressed: _onDeleteSchedules,
        iconSize: 32,
      ));

      actions.add(IconButton(
        icon: Icon(Icons.note_alt_outlined),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => EnlistmentPage())),
        iconSize: 32,
      ));
    }

    actions.add(addButton);

    return actions;
  }

  void _onDeleteSchedules() async {
    await AlertModal.showAlert(
      context,
      header: 'Delete schedule?',
      onAccept: () =>
          Provider.of<ClassSchedule>(context, listen: false).deleteSchedules(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //The property and builder changes the DrawerWidget's icon to customize
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(context).openDrawer(),
            iconSize: 32,
          ),
        ),
        actions: _getAppBarActions(),
      ),
      body: _buildBody(),
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
            label: 'Classes',
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
