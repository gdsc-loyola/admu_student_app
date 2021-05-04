import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/screens/main_app.dart';
import 'package:admu_student_app/screens/splash_page.dart';

void main() {
  runApp(App());
}

const PrimaryColor =
    const Color(0xFF855AFF); //Color of App Bar and Navigation Bar

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.dmSansTextTheme(
            Theme.of(context).textTheme,
        ),
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
      home: SplashPage(), // change this to Splash screen
      // Splash screen -> Login -> (Onboarding) -> Main Page
    );
  }
}
