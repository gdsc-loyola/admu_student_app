import 'package:flutter/material.dart';

class Course extends ChangeNotifier {
  String _courseCode;
  int _units;
  double _qpi;
  bool _isIncludedInQPI;

  String get code => _courseCode;
  int get units => _units;
  double get qpi => _qpi;
  bool get isIncludedInQPI => _isIncludedInQPI;

  Course(String courseCode, int units, double qpi, bool isIncludedInQPI) {
    _courseCode = courseCode;
    _units = units;
    _qpi = qpi;
    _isIncludedInQPI = isIncludedInQPI;
  }
}
