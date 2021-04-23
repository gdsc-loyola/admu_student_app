import 'package:admu_student_app/models/semester.dart';

class Year {
  int _yearNum;
  int _units;
  double _qpi;
  List<Semester> _sems = [];

  int get yearNum => _yearNum;

  String get yearString {
    switch (_yearNum) {
      case 1:
        return 'Freshman Year';
      case 2:
        return 'Sophomore Year';
      case 3:
        return 'Junior Year';
      case 4:
        return 'Senior Year';
      case 5:
        return 'Super Senior Year';
      default:
        return 'Year $_yearNum';
    }
  }

  int get units {
    if (_units == null) {
      int totalUnits = 0;

      for (Semester s in _sems) totalUnits += s.units;

      return totalUnits;
    } else
      return _units;
  }

  double get yearlyQPI {
    if (_qpi == null) {
      double sumGrades = 0;
      int totalUnits = 0;

      for (Semester s in _sems) {
        sumGrades += s.semestralQPI * s.units;
        totalUnits += s.units;
      }

      if (totalUnits == 0) return 0.0;
      return sumGrades / totalUnits;
    } else
      return _qpi;
  }

  List<Semester> get sems => _sems;

  Year(int num, List<Semester> sems) {
    _yearNum = num;
    _sems = sems;
  }

  Year.fromYear(int num, int units, double qpi) {
    _yearNum = num;
    _units = units;
    _qpi = qpi;
  }
}
