import 'package:flutter/material.dart';

import 'package:admu_student_app/screens/enlistment/enlistment_classes.dart';

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
                MaterialPageRoute(builder: (_) => EnlistmentClassesPage()),
              );
            },
            child: Text('view semester'),
          ),
        ],
      ),
    );
  }
}
