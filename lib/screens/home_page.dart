import 'package:flutter/material.dart';

import 'package:admu_student_app/screens/home/pomodoro_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => PomodoroPage()),
            );
          },
          child: Text('Pomodoro'),
        ),
      ],
    );
  }
}
