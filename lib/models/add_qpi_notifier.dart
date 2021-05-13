import 'package:flutter/material.dart';

class AddQPINotifier extends ChangeNotifier {
  int _semNum = -1;
  int _gradeVal = 1;

  get semNum => _semNum;
  get gradeVal => _gradeVal;

  set semNum(int semNum) {
    _semNum = semNum;
    notifyListeners();
  }

  set gradeVal(int gradeVal) {
    _gradeVal = gradeVal;
    notifyListeners();
  }
}
