import 'package:admu_student_app/models/year.dart';
import 'package:admu_student_app/widgets/qpi/qpi_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QPIPage extends StatefulWidget {
  @override
  _QPIPageState createState() => _QPIPageState();
}

class _QPIPageState extends State<QPIPage> {
  @override
  Widget build(BuildContext context) {

    return QPIDropDown();
  }
}

