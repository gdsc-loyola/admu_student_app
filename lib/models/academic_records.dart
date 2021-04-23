import 'package:flutter/material.dart';

import 'package:admu_student_app/models/course.dart';
import 'package:admu_student_app/models/semester.dart';
import 'package:admu_student_app/models/year.dart';

class AcademicRecords extends ChangeNotifier {
  // sample data for testing purposes
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

  get years => _years;

  // testing purposes
  get sems {
    // query from database
    return _years[0].sems;
  }

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

  void addYearlyQPI(int yearNum, int units, double qpi) async {
    // add to database
    // key YEAR_Y

    _updateList();
  }

  void editYearlyQPI(int yearNum, int units, double qpi) async {
    // edit from database
    // key YEAR_Y

    _updateList();
  }

  void deleteYearlyQPI(int yearNum) async {
    // delete from database
    // key YEAR_Y

    _updateList();
  }

  void addSemestralQPI(int yearNum, int semNum, int units, double qpi) async {
    // add to database
    // key SEM_Y_S

    _updateList();
  }

  void editSemestralQPI(int yearNum, int semNum, int units, double qpi) async {
    // edit from database
    // key SEM_Y_S
  }

  void deleteSemestralQPI(int yearNum, int semNum) async {
    // delete from database
    // key SEM_Y_S

    _updateList();
  }

  void addCourse(int yearNum, int semNum, String code, int units, double qpi,
      bool isIncludedInQPI) async {
    // add to database
    // key CODE

    _updateList();
  }

  void editCourse(String code, double newQPI) {
    // edit from database
    // key CODE

    // testing purposes
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

  void deleteCourse(String code) async {
    // delete from database
    // key CODE

    _updateList();
  }

  void _updateList() async {
    // query from database: table of courses

    notifyListeners();
  }
}
