import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QPIView extends StatelessWidget {
  double _value = 0.0;

  QPIView(double val) {
    _value = val;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.blue,
      ),
      height: 80,
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${_value.toStringAsFixed(2)}',
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: 32,
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
