import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  InputField({
    Key key,
    this.isMultiLined,
    this.length,
    @required this.controller,
  }) : super(key: key);

  final bool isMultiLined;
  final int length;
  final TextEditingController controller;

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.multiline, //expands when make lagpas
        maxLines: widget.isMultiLined == true ? null : 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Lorem Ipsum',
          counterText: "", //Disables maxLength showing in Field
        ),
        maxLength: widget.length,
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
