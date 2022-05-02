import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/_all_courses.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/ls_directory.dart';
import 'package:admu_student_app/models/notification_center.dart';
import 'package:admu_student_app/models/user_cache.dart';
import 'package:admu_student_app/screens/splash_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AllCourses()),
      ChangeNotifierProvider(create: (_) => CalendarEvents()),
      ChangeNotifierProvider(create: (_) => NotificationCenter()),
    ],
    child: App(),
  ));

  // load - after runApp to avoid errors
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LSDirectory.load();
    UserCache.load(context);

    MaterialApp app = MaterialApp(
      title: 'Beadle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.GRAY_LIGHT[2],
        fontFamily: GoogleFonts.asap().fontFamily,
        textTheme: TextTheme(
          headline4: GoogleFonts.asap(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
          headline5: GoogleFonts.asap(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
          headline6: GoogleFonts.asap(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
          bodyText1: GoogleFonts.asap(fontSize: 16.0),
          bodyText2: GoogleFonts.asap(fontSize: 14.0),
          caption: GoogleFonts.asap(fontSize: 14.0),
        ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: AppColors.PRIMARY_MAIN,
              brightness: Brightness.dark,
            ),
        primaryColor: AppColors.PRIMARY_MAIN,
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );

    return GestureDetector(
      onTap: () {
        FocusScopeNode focus = FocusScope.of(context);

        if (!focus.hasPrimaryFocus) focus.unfocus();
      },
      child: app,
    );
  }
}
