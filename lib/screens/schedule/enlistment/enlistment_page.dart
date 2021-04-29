import 'package:flutter/material.dart';

import 'package:admu_student_app/screens/schedule/enlistment/enlistment_semester.dart';

class EnlistmentPage extends StatefulWidget {
  @override
  _EnlistmentPageState createState() => _EnlistmentPageState();
}

class _EnlistmentPageState extends State<EnlistmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('this is the enlistment page'),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => EnlistmentSemesterPage()),
              );
            },
            child: Text('view semester'),
          ),
        ],
      ),
    );
  }
}
