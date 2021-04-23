import 'package:flutter/material.dart';

import 'package:admu_student_app/models/Year.dart';
import 'package:admu_student_app/models/Semester.dart';
import 'package:admu_student_app/models/Course.dart';

class AcademicRecords extends ChangeNotifier {
  List<Year> _years;

  double get cumulativeQPI {
    double sumGrades = 0;
    double totalUnits = 0;

    for (Year y in _years) {
      sumGrades += y.yearlyQPI * y.units;
      totalUnits += y.units;
    }

    if (totalUnits == 0) return 0.0;
    return sumGrades / totalUnits;
  }

  List<Year> get years {
    return _years;

    // query
    // act ual return: List<Year>
  }

  List<String> get scheduleList {
    return ["FRESHMAN - SEM 1 - Q1", "FRESHMAN - SEM 1 - Q2"];

    // query
    // loop
    // used for schedule screen
  }

  AcademicRecords() {
    _years = [
      Year(1, [
        Semester(1, [
          Course('CSCI 20', 3, 4.0, true),
          Course('CSCI 21', 3, 4.0, true),
          Course('ENGL 11', 3, 4.0, true),
          Course('FILI 12', 3, 2.5, true),
          Course('INTACT 11', 0, 0.0, false),
          Course('MATH 10', 3, 4.0, true),
          Course('MATH 21', 3, 4.0, true),
          Course('PHYED 111', 2, 4.0, false),
        ]),
      ]),
    ];
  }
}
