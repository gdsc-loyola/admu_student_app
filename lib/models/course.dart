import 'package:admu_student_app/models/central_database.dart';

class Course {
  String courseCode;
  int color;
  int units;
  double qpi;
  bool isIncludedInQPI;

  Course(String courseCode, int color, int units, double qpi,
      bool isIncludedInQPI) {
    this.courseCode = courseCode;
    this.color = color;
    this.units = units;
    this.qpi = qpi;
    this.isIncludedInQPI = isIncludedInQPI;
  }

  String get letterGrade {
    if (qpi == 4.0)
      return 'A';
    else if (qpi == 3.5)
      return 'B+';
    else if (qpi == 3.0)
      return 'B';
    else if (qpi == 2.5)
      return 'C+';
    else if (qpi == 2.0)
      return 'C';
    else if (qpi == 1.0)
      return 'D';
    else if (qpi == 0.0)
      return 'F';
    else
      return '?';
  }

  factory Course.fromMap(Map map) {
    return Course(
      map[CentralDatabaseHelper.code],
      map[CentralDatabaseHelper.color],
      map[CentralDatabaseHelper.units],
      map[CentralDatabaseHelper.qpi],
      map[CentralDatabaseHelper.isIncludedInQPI] == 1,
    );
  }
}
