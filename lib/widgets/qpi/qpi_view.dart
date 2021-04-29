import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:admu_student_app/main.dart';

class QPIView extends StatelessWidget {
  final double value;

  QPIView({@required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: PrimaryColor,
      ),
      height: 80,
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${value.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
