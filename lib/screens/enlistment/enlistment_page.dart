import 'package:flutter/material.dart';

import 'package:admu_student_app/widgets/enlistment/enlistment_class.dart';

class EnlistmentPage extends StatefulWidget {
  @override
  _EnlistmentPageState createState() => _EnlistmentPageState();
}

class _EnlistmentPageState extends State<EnlistmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('this is the enlistment page'),
            EnlistmentClassCard(),
            EnlistmentClassCard(),
            EnlistmentClassCard(),
          ],
        ),
      ),
    );
  }
}
