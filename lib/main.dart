import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/academic_records.dart';
import 'package:admu_student_app/screens/splash_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AcademicRecords()),
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // textTheme: GoogleFonts.dmSansTextTheme(
        //   Theme.of(context).textTheme,
        // ),
        fontFamily: GoogleFonts.dmSans().fontFamily,
        textTheme: TextTheme(
          headline4: GoogleFonts.dmSans(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
          headline5: GoogleFonts.dmSans(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
          headline6: GoogleFonts.dmSans(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
          bodyText1: GoogleFonts.dmSans(fontSize: 16.0),
          bodyText2: GoogleFonts.dmSans(fontSize: 14.0),
          caption: GoogleFonts.dmSans(fontSize: 14.0),
        ),
        primaryColor: AppColors.PRIMARY_MAIN, //#AB8CFF
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
