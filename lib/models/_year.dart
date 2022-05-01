import 'package:admu_student_app/models/_semester.dart';

class Year {
  int _yearNum;
  int _units;
  double _qpi;
  List<Semester> sems = [];

  // get year number
  int get yearNum => _yearNum;

  // get year string
  String get yearString => 'Year $_yearNum';

  // get whether yearly qpi or not
  bool get isYearlyQPI => _qpi != null;

  // get total number of units
  int get units {
    if (_units == null) {
      int totalUnits = 0;

      for (Semester s in sems) totalUnits += s.units;

      return totalUnits;
    } else {
      return _units;
    }
  }

  // setter for year number
  set yearNum(int nYearNum) {
    this._yearNum = nYearNum;
  }

  // setter for units (yearly qpi)
  set units(int nUnits) {
    _units = nUnits;
  }

  // setter for qpi (yearly qpi)
  set qpi(double qpi) {
    _qpi = qpi;
  }

  // getter for yearly qpi
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
    } else {
      return _qpi;
    }
  }

  // default constructor
  Year(int num, List<Semester> sems) {
    _yearNum = num;
    this.sems = sems;
  }

  // constructor for yearly qpi
  Year.fromYear(int num, int units, double qpi) {
    _yearNum = num;
    _units = units;
    _qpi = qpi;
  }
}
