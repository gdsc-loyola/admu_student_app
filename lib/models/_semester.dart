import 'package:admu_student_app/models/_course.dart';

class Semester {
  int _semNum;
  int _units;
  double _qpi;
  List<Course> courses = [];

  // get semester number
  int get semNum => _semNum;

  // get name of semester
  String get semString {
    switch (_semNum) {
      case 0:
        return 'Intersession';
      case 1:
        return 'First Semester';
      case 2:
        return 'Second Semester';
      default:
        return '?';
    }
  }

  // get whether semestral qpi or not
  bool get isSemestralQPI => _qpi != null;

  // get total number of units
  int get allUnits {
    if (_units == null) {
      int totalUnits = 0;

      for (Course c in courses) totalUnits += c.units;

      return totalUnits;
    } else {
      return _units;
    }
  }

  // get total number of qpi units
  int get units {
    if (_units == null) {
      int totalUnits = 0;

      for (Course c in courses) {
        if (c.isIncludedInQPI) totalUnits += c.units;
      }

      return totalUnits;
    } else {
      return _units;
    }
  }

  // setter for units (semestral qpi)
  set units(int nUnits) {
    _units = nUnits;
  }

  // setter for qpi (semestral qpi)
  set qpi(double qpi) {
    _qpi = qpi;
  }

  // getter for semestral qpi
  double get semestralQPI {
    if (_qpi == null) {
      double sumGrades = 0;
      int totalUnits = 0;

      for (Course c in courses) {
        if (c.isIncludedInQPI) {
          sumGrades += c.qpi * c.units;
          totalUnits += c.units;
        }
      }

      if (totalUnits == 0) return 0.0;
      return sumGrades / totalUnits;
    } else {
      return _qpi;
    }
  }

  // default constructor
  Semester(int num, List<Course> courses) {
    _semNum = num;
    this.courses = courses;
  }

  // constructor for semestral qpi
  Semester.fromSem(int num, int units, double qpi) {
    _semNum = num;
    _units = units;
    _qpi = qpi;
  }
}
