import 'package:admu_student_app/models/semester.dart';

class Year {
  int _yearNum;
  int _units;
  double _qpi;
  List<Semester> sems = [];

  int get yearNum => _yearNum;

  String get yearString => 'Year $_yearNum';

  bool get isYearlyQPI => _qpi == null;

  int get allUnits {
    if (_units == null) {
      int totalUnits = 0;

      for (Semester s in sems) totalUnits += s.units;

      return totalUnits;
    } else
      return _units;
  }

  int get units {
    if (_units == null) {
      int totalUnits = 0;

      for (Semester s in sems) totalUnits += s.units;

      return totalUnits;
    } else
      return _units;
  }

  set qpi(double qpi) {
    _qpi = qpi;
  }

  double get yearlyQPI {
    if (_qpi == null) {
      double sumGrades = 0;
      int totalUnits = 0;

      for (Semester s in sems) {
        sumGrades += s.semestralQPI * s.units;
        totalUnits += s.units;
      }

      if (totalUnits == 0) return 0.0;
      return sumGrades / totalUnits;
    } else
      return _qpi;
  }

  Year(int num, List<Semester> sems) {
    _yearNum = num;
    this.sems = sems;
  }

  Year.fromYear(int num, int units, double qpi) {
    _yearNum = num;
    _units = units;
    _qpi = qpi;
  }
}
