import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/screens/drawer/about_page.dart';
import 'package:admu_student_app/screens/drawer/directory_page.dart';
import 'package:admu_student_app/screens/drawer/faqs_page.dart';
import 'package:admu_student_app/screens/enlistment/enlistment_page.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'LOREM I. PSUM',
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            accountEmail: Text(
              'lorem.ipsum.@obf.ateneo.edu',
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w100,
                  color: Colors.white70,
                ),
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColors.PRIMARY_MAIN,
              child: new Container(
                width: 100,
                height: 100,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  //container can be changed to:
                  //backgroundImage: NetworkImage("photo url"),
                ),
              ),
            ),
          ),

          //LIST TILE 1
          ListTile(
            title: Container(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Text('Lorem Ipsum 1 - LS DIRECTORY'),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => DirectoryPage()),
              );
            },
          ),

          //LIST TILE 2
          ListTile(
            title: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Text('Lorem Ipsum 2 - ENLISTMENT'),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => EnlistmentPage()),
              );
            },
          ),

          //LIST TILE 3
          ListTile(
            title: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Text('Lorem Ipsum 3 - ABOUT'),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => AboutPage()),
              );
            },
          ),

          //LIST TILE 4
          ListTile(
            title: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Text('Lorem Ipsum 4 - FAQS'),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => FAQsPage()),
              );
            },
          ),

          //LIST TILE 5
          ListTile(
            title: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Text('Lorem Ipsum 5'),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          //LIST TILE 6
          ListTile(
            title: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: Text('Log Out'),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
