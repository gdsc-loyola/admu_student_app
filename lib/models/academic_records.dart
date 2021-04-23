import 'package:flutter/material.dart';

import 'package:admu_student_app/models/year.dart';
import 'package:admu_student_app/models/semester.dart';
import 'package:admu_student_app/models/course.dart';

class AcademicRecords extends ChangeNotifier {
  List<Year> _years = [
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
      Semester(2, [
        Course('CSCI 22', 3, 4.0, false),
        Course('ENLIT 12', 3, 4.0, false),
        Course('FILI 11', 3, 4.0, false),
        Course('HISTO 11', 3, 4.0, false),
        Course('INTACT 12', 0, 0.0, false),
        Course('MATH 30.23', 3, 4.0, false),
        Course('PHYED 143', 2, 4.0, false),
        Course('SocSc 11', 3, 4.0, false),
        Course('THEO 11', 3, 4.0, false),
      ]),
    ]),
  ];

  // get years async {
  // // query from database
  // }

  get sems {
    // query from database
    return _years[0].sems;
  }

  // get list of courses in specific year and sem
  List<Course> getCourses(int year, int sem) {
    if (year == 1 && sem == 1) {
      return _years[0].sems[0].courses;
    } else if (year == 1 && sem == 2) {
      return _years[0].sems[1].courses;
    } else
      return [];
  }

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

  double getSemestralQPI(int yearNum, int semNum) {
    for (Year y in _years) {
      if (y.yearNum == yearNum) {
        for (Semester s in y.sems) {
          if (s.semNum == semNum) {
            return s.semestralQPI;
          }
        }
      }
    }

    return 0.0;
  }

  void editCourse(String code, double newQPI) {
    // update in database with PRIMARY KEY code

    for (Year y in _years) {
      for (Semester s in y.sems) {
        for (Course c in s.courses) {
          if (c.courseCode == code) {
            c.qpi = newQPI;
            _updateList();
            return;
          }
        }
      }
    }

    _updateList();
  }

  void _updateList() {
    // refresh inner list from database
    // _years = years;
    notifyListeners();
  }
}
