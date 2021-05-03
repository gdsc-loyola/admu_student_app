import 'package:flutter/material.dart';

import 'package:admu_student_app/main.dart';

class HalfTextField extends StatefulWidget {
  @override
  _HalfTextFieldState createState() => _HalfTextFieldState();
}

class _HalfTextFieldState extends State<HalfTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2.5,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Lorem Ipsum',
          counterText: "", //Disables maxLength showing in Field
        ),
        maxLength: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    );
  }
}
