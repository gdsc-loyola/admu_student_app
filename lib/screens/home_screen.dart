import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

const PrimaryColor = const Color(0xFF9873FF);

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
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, //Highlights which page the user is
        type: BottomNavigationBarType.fixed,
        //iconSize: ,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/home_unclicked.png"),
            ),
              title: Text('Home'),
          ),

          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/calendar_unclicked.png"),
            ),
            title: Text('Calendar'),
            ),

          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/clock_unclicked.png"),
            ),
            title: Text('Schedule'),
          ),

          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/qpi_unclicked.png"),
            ),
            title: Text('QPI'),
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

