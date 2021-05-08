import 'package:admu_student_app/models/course.dart';

class Semester {
  int _semNum;
  int _units;
  double _qpi;
  List<Course> courses = [];

  int get semNum => _semNum;

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

  bool get isSemestralQPI => _qpi == null;

  int get allUnits {
    if (_units == null) {
      int totalUnits = 0;

      for (Course c in courses) totalUnits += c.units;

      return totalUnits;
    } else
      return _units;
  }

  int get units {
    if (_units == null) {
      int totalUnits = 0;

      for (Course c in courses) {
        if (c.isIncludedInQPI) totalUnits += c.units;
      }

      return totalUnits;
    } else
      return _units;
  }

  set qpi(double qpi) {
    _qpi = qpi;
  }

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
    } else
      return _qpi;
  }

  Semester(int num, List<Course> courses) {
    _semNum = num;
    this.courses = courses;
  }

  Semester.fromSem(int num, int units, double qpi) {
    _semNum = num;
    _units = units;
    _qpi = qpi;
  }
}
