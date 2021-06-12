import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/screens/drawer/about_page.dart';
import 'package:admu_student_app/screens/drawer/directory_page.dart';
import 'package:admu_student_app/screens/enlistment/enlistment_page.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            Container(
              // height: 64,
              color: AppColors.PRIMARY_MAIN,
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).padding.top, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      iconSize: 32),
                ],
              ),
            ),
            Container(
              height: 216,
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: AppColors.PRIMARY_MAIN,
                  child: new Container(
                    width: 80,
                    height: 80,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      //container can be changed to:
                      //backgroundImage: NetworkImage("photo url"),
                    ),
                  ),
                ),
                accountName: Text(
                  'LOREM I. PSUM',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white),
                ),
                accountEmail: Text(
                  'lorem.ipsum.@obf.ateneo.edu',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: AppColors.GRAY_LIGHT[0],
                      fontWeight: FontWeight.w100),
                ),
              ),
            ),

            //LIST TILE 1
            ListTile(
              title: Container(
                padding: EdgeInsets.fromLTRB(0, 44, 0, 11.5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.GRAY_LIGHT[1]),
                  ),
                ),
                child: Text(
                  'Enlistment',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: AppColors.GRAY_DARK[0], fontSize: 20),
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => EnlistmentPage()));
              },
            ),

            //LIST TILE 2
            ListTile(
              title: Container(
                padding: EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.GRAY_LIGHT[1]),
                  ),
                ),
                child: Text(
                  'LS Adress Book',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: AppColors.GRAY_DARK[0], fontSize: 20),
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => DirectoryPage()));
              },
            ),

            //LIST TILE 3
            ListTile(
              title: Container(
                padding: EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.GRAY_LIGHT[1]),
                  ),
                ),
                child: Text(
                  'About',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: AppColors.GRAY_DARK[0],
                        fontSize: 20
                      ),
                ),
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
                padding: EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.GRAY_LIGHT[1]),
                  ),
                ),
                child: Text(
                  'Log out',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: AppColors.GRAY_DARK[0],
                        fontSize: 20
                      ),
                ),
              ),
              onTap: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (_) => FAQsPage()),
                // );
              },
            ),

            Spacer(),

            Container(
              padding: EdgeInsets.fromLTRB(16, 0, 0, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Made by:',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: AppColors.GRAY_DARK[2]),
                  ),
                  Row(
                    children: [
                      Image.asset('assets/logo/dsc.png', width: 36, height: 36),
                      Text(
                        'Developer Student Clubs Loyola',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: AppColors.GRAY_DARK[2]),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
