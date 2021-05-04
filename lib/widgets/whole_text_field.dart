import 'package:flutter/material.dart';

class WholeTextField extends StatefulWidget {
  @override
  _WholeTextFieldState createState() => _WholeTextFieldState();
}

class _WholeTextFieldState extends State<WholeTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: TextField(

          maxLines: 1,
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
