import 'package:flutter/material.dart';

import 'package:admu_student_app/main.dart';

class ExpandedTextField extends StatefulWidget {
  @override
  _ExpandedTextFieldState createState() => _ExpandedTextFieldState();
}

class _ExpandedTextFieldState extends State<ExpandedTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: TextField(
          keyboardType: TextInputType.multiline, //expands when make lagpas
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Lorem Ipsum',
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }
}
