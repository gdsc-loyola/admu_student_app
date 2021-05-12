import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:admu_student_app/models/central_database.dart';
import 'package:admu_student_app/models/course.dart';
import 'package:admu_student_app/models/semester.dart';
import 'package:admu_student_app/models/year.dart';

class AcademicRecords extends ChangeNotifier {
  // sample data for testing purposes
  final List<Year> _sampleData = [
    Year(1, [
      Semester(1, [
        Course('CSCI 20', 0xFFAE0000, 3, 0.0, true),
        Course('CSCI 21', 0xFF00AE00, 3, 1.0, true),
        Course('ENGL 11', 0xFF0000AE, 3, 2.0, true),
        Course('FILI 12', 0xFFAE0000, 3, 2.5, true),
        Course('INTACT 11', 0xFF00AE00, 0, 0.0, false),
        Course('MATH 10', 0xFF0000AE, 3, 3.0, true),
        Course('MATH 21', 0xFFAE0000, 3, 3.5, true),
        Course('PHYED 111', 0xFF00AE00, 2, 4.0, false),
      ]),
      Semester(2, [
        Course('CSCI 22', 0, 3, 4.0, false),
        Course('ENLIT 12', 0, 3, 4.0, false),
        Course('FILI 11', 0, 3, 4.0, false),
        Course('HISTO 11', 0, 3, 4.0, false),
        Course('INTACT 12', 0, 0, 0.0, false),
        Course('MATH 30.23', 0, 3, 4.0, false),
        Course('PHYED 143', 0, 2, 4.0, false),
        Course('SocSc 11', 0, 3, 4.0, false),
        Course('THEO 11', 0, 3, 4.0, false),
      ]),
    ]),
    Year(2, [
      Semester(0, [
        Course('MATH NSCI TECH ELECTIVE', 0, 3, 0.0, true),
        Course('SocSc 12', 0, 3, 1.0, true),
        Course('MATH 30.24', 0, 3, 2.0, true),
      ]),
      Semester.fromSem(1, 20, 3.5),
    ]),
    Year.fromYear(3, 20, 4.0),
  ];
  List<Year> _years = [];

  get years => _years;

  AcademicRecords() {
    // sample data for testing
    if (kIsWeb) _years.addAll(_sampleData);

    _updateList();
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

  Year getYear(int yearNum) {
    for (Year y in _years) {
      if (y.yearNum == yearNum) return y;
    }

    return null;
  }

  Semester getSemester(int yearNum, int semNum) {
    for (Year y in _years) {
      if (y.yearNum == yearNum) {
        for (Semester s in y.sems) {
          if (s.semNum == semNum) {
            return s;
          }
        }
      }
    }

    return null;
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

  void addCourse(int yearNum, int semNum, String code, int color, int units,
      double qpi, bool isIncludedInQPI) async {
    if (kIsWeb) {
      bool foundYear = false;
      Course newCourse = Course(code, color, units, qpi, isIncludedInQPI);
      for (Year y in _years) {
        if (y.yearNum == yearNum) {
          foundYear = true;
          bool foundSem = false;
          for (Semester s in y.sems) {
            if (s.semNum == semNum) {
              foundSem = true;
              s.courses.add(newCourse);
              break;
            }
          }

          if (!foundSem) y.sems.add(Semester(semNum, [newCourse]));
        }
      }

      if (!foundYear)
        _years.add(Year(yearNum, [
          Semester(semNum, [newCourse])
        ]));

      _updateList();
      return;
    }

    // add to database
    int id = await (await CentralDatabaseHelper.instance.database).insert(
      CentralDatabaseHelper.tableName_courses,
      {
        CentralDatabaseHelper.code: code,
        CentralDatabaseHelper.year: yearNum,
        CentralDatabaseHelper.sem: semNum,
        CentralDatabaseHelper.color: color,
        CentralDatabaseHelper.units: units,
        CentralDatabaseHelper.qpi: qpi,
        CentralDatabaseHelper.isIncludedInQPI: isIncludedInQPI ? 1 : 0,
      },
    );

    print('added new course, id: $id');

    _updateList();
  }

  void editCourse(
      int oldYearNum,
      int oldSemNum,
      String oldCode,
      int newYearNum,
      int newSemNum,
      String newCode,
      int newColor,
      int newUnits,
      double newQPI,
      bool newIsIncludedInQPI) async {
    // edit from database
    // await (await CentralDatabaseHelper.instance.database).update(
    //     CentralDatabaseHelper.tableName_courses, {},
    //     where:
    //         '${CentralDatabaseHelper.year} = ?, ${CentralDatabaseHelper.sem} = ?, ${CentralDatabaseHelper.code} = ?',
    //     whereArgs: [yearNum, semNum, code]);

    // query row
    // int changed = await (await CentralDatabaseHelper.instance.database).update(
    //   CentralDatabaseHelper.tableName_courses,
    //   {
    //     CentralDatabaseHelper.code: newCode,
    //     CentralDatabaseHelper.year: newYearNum,
    //     CentralDatabaseHelper.sem: newSemNum,
    //     CentralDatabaseHelper.color: newColor,
    //     CentralDatabaseHelper.units: newUnits,
    //     CentralDatabaseHelper.qpi: newQPI,
    //     CentralDatabaseHelper.isIncludedInQPI: newIsIncludedInQPI ? 1 : 0,
    //   },
    //   where:
    //       '${CentralDatabaseHelper.year} = ?, ${CentralDatabaseHelper.sem} = ?, ${CentralDatabaseHelper.code} = ?',
    //   whereArgs: [oldYearNum, oldSemNum, oldCode],
    // );
    // update

    // testing purposes, to edit
    for (Year y in _years) {
      for (Semester s in y.sems) {
        for (Course c in s.courses) {
          if (c.courseCode == oldCode) {
            c.qpi = newQPI;
            _updateList();
            return;
          }
        }
      }
    }

    _updateList();
  }

  void deleteCourse(int yearNum, int semNum, String code) async {
    if (kIsWeb) {
      for (Year y in _years) {
        if (y.yearNum == yearNum) {
          for (Semester s in y.sems) {
            if (s.semNum == semNum) {
              // s.courses.remove();
              _updateList();
              return;
            }
          }
        }
      }
    }

    // delete from database
    int numDeleted =
        await (await CentralDatabaseHelper.instance.database).delete(
      CentralDatabaseHelper.tableName_courses,
      where:
          '${CentralDatabaseHelper.year} = ?, ${CentralDatabaseHelper.sem} = ?, ${CentralDatabaseHelper.code} = ?',
      whereArgs: [yearNum, semNum, code],
    );

    print('deleted $numDeleted');

    _updateList();
  }

  void _updateList() async {
    if (kIsWeb) {
      // sort years
      _years.sort((a, b) => a.yearNum.compareTo(b.yearNum));

      // sort sems
      for (Year y in _years) {
        if (y.sems.length > 0) {
          y.sems.sort((a, b) => a.semNum.compareTo(b.semNum));
          for (Semester s in y.sems) {
            if (s.courses.length > 0) {
              s.courses.sort((a, b) => a.courseCode.compareTo(b.courseCode));
            }
          }
        }
      }

      // sort courses

      notifyListeners();
      return;
    }

    // get list of rows
    List<Map<String, dynamic>> tempRows =
        await (await CentralDatabaseHelper.instance.database).query(
            CentralDatabaseHelper.tableName_courses,
            orderBy: '${CentralDatabaseHelper.year} ASC');

    _years = [];

    // create courses
    tempRows.forEach((row) {
      String code = row[CentralDatabaseHelper.code];

      if (code.startsWith('Y_')) {
        // add year qpi
        // Y_Y
        bool foundYear = false;
        int yearNum = int.parse(code[2]);

        for (Year y in _years) {
          if (y.yearNum == yearNum) {
            foundYear = true;
            y.qpi = row[CentralDatabaseHelper.qpi];
            break;
          }
        }

        if (!foundYear)
          _years.add(new Year.fromYear(
            yearNum,
            row[CentralDatabaseHelper.units],
            row[CentralDatabaseHelper.qpi],
          ));
      } else if (code.startsWith('S_')) {
        // add sem qpi
        // S_Y_S
        bool foundYear = false;
        int yearNum = int.parse(code[2]);
        int semNum = int.parse(code[4]);
        Semester newSem = Semester.fromSem(
          row[CentralDatabaseHelper.sem],
          row[CentralDatabaseHelper.units],
          row[CentralDatabaseHelper.qpi],
        );

        for (Year y in _years) {
          if (y.yearNum == yearNum) {
            foundYear = true;
            bool foundSem = false;
            for (Semester s in y.sems) {
              if (s.semNum == semNum) {
                foundSem = true;
                s.qpi = row[CentralDatabaseHelper.qpi];
                break;
              }
            }

            if (!foundSem) y.sems.add(newSem);

            break;
          }
        }

        if (!foundYear) _years.add(Year(yearNum, [newSem]));
      } else {
        // add course
        bool foundYear = false;
        int yearNum = row[CentralDatabaseHelper.year];
        int semNum = row[CentralDatabaseHelper.sem];
        Course newCourse = Course.fromMap(row);

        for (Year y in _years) {
          if (y.yearNum == yearNum) {
            foundYear = true;
            bool foundSem = false;

            for (Semester s in y.sems) {
              if (s.semNum == semNum) {
                foundSem = true;
                s.courses.add(newCourse);
                break;
              }
            }

            if (!foundSem) y.sems.add(Semester(semNum, [newCourse]));

            break;
          }
        }

        if (!foundYear)
          _years.add(Year(yearNum, [
            Semester(semNum, [newCourse])
          ]));
      }
    });

    notifyListeners();
  }

  void deleteAllData() async {
    if (kIsWeb) {
      _years.clear();
      _years.addAll(_sampleData);
      print('deleted and recreated all course data - web');
      _updateList();
      return;
    }

    await CentralDatabaseHelper.instance.createCoursesTable(null, 0);

    print('deleted and recreated all course data');
    _updateList();
  }
}
