import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/central_database.dart';
import 'package:admu_student_app/models/course.dart';
import 'package:admu_student_app/models/semester.dart';
import 'package:admu_student_app/models/year.dart';

class AcademicRecords extends ChangeNotifier {
  // sample data for testing purposes
  final List<Year> _sampleData = [
    Year(1, [
      Semester(1, [
        Course(0, 'CSCI 20', AppColors.ACCENTS[0].value, 3, 0.0, true),
        Course(0, 'CSCI 21', AppColors.ACCENTS[1].value, 3, 1.0, true),
        Course(0, 'ENGL 11', AppColors.ACCENTS[2].value, 3, 2.0, true),
        Course(0, 'FILI 12', AppColors.ACCENTS[3].value, 3, 2.5, true),
        Course(0, 'INTACT 11', AppColors.ACCENTS[4].value, 0, 0.0, false),
        Course(0, 'MATH 10', AppColors.ACCENTS[0].value, 3, 3.0, true),
        Course(0, 'MATH 21', AppColors.ACCENTS[1].value, 3, 3.5, true),
        Course(0, 'PHYED 111', AppColors.ACCENTS[2].value, 2, 4.0, false),
      ]),
      Semester(2, [
        Course(0, 'CSCI 22', AppColors.ACCENTS[0].value, 3, 4.0, false),
        Course(0, 'ENLIT 12', AppColors.ACCENTS[1].value, 3, 4.0, false),
        Course(0, 'FILI 11', AppColors.ACCENTS[2].value, 3, 4.0, false),
        Course(0, 'HISTO 11', AppColors.ACCENTS[3].value, 3, 4.0, false),
        Course(0, 'INTACT 12', AppColors.ACCENTS[4].value, 0, 0.0, false),
        Course(0, 'MATH 30.23', AppColors.ACCENTS[0].value, 3, 4.0, false),
        Course(0, 'PHYED 143', AppColors.ACCENTS[1].value, 2, 4.0, false),
        Course(0, 'SocSc 11', AppColors.ACCENTS[2].value, 3, 4.0, false),
        Course(0, 'THEO 11', AppColors.ACCENTS[3].value, 3, 4.0, false),
      ]),
    ]),
    Year(2, [
      Semester(0, [
        Course(0, 'MATH NSCI TECH ELECTIVE', AppColors.ACCENTS[0].value, 3, 0.0,
            true),
        Course(0, 'SocSc 12', AppColors.ACCENTS[1].value, 3, 1.0, true),
        Course(
            0, 'MATH 30.24', 0xFF006060, 3, 2.0, true), // custom test for color
      ]),
      Semester.fromSem(1, 20, 3.5),
    ]),
    Year.fromYear(3, 20, 4.0),
  ];
  List<Year> _years = [];

  get years => _years;

  AcademicRecords() {
    // sample data for testing
    // if (kIsWeb) _years.addAll(_sampleData);

    _updateList();
  }

  List<Course> getCourses(int year, int sem) {
    for (Year y in _years) {
      if (y.yearNum == year) {
        for (Semester s in y.sems) {
          if (s.semNum == sem) {
            return s.courses;
          }
        }
      }
    }

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
    if (kIsWeb) {
      bool foundYear = false;
      Year newYear = Year.fromYear(yearNum, units, qpi);

      for (Year y in _years) {
        if (y.yearNum == yearNum) {
          y.units = units;
          y.qpi = qpi;
          foundYear = true;
          break;
        }
      }

      if (!foundYear) _years.add(newYear);

      _updateList();
      return;
    }

    int id = await (await CentralDatabaseHelper.instance.database).insert(
      CentralDatabaseHelper.tableName_courses,
      {
        CentralDatabaseHelper.code: 'Y_$yearNum',
        CentralDatabaseHelper.year: yearNum,
        CentralDatabaseHelper.units: units,
        CentralDatabaseHelper.qpi: qpi,
        CentralDatabaseHelper.isIncludedInQPI: 1,
      },
    );

    print('added year qpi, id: $id');

    _updateList();
  }

  void editYearlyQPI(Year year, int yearNum, int units, double qpi) async {
    if (kIsWeb) {
      for (Year y in _years) {
        if (y.yearNum == year.yearNum) {
          y.yearNum = yearNum;
          y.units = units;
          y.qpi = qpi;

          _updateList();
          return;
        }
      }
    }

    int updated = await (await CentralDatabaseHelper.instance.database).update(
      CentralDatabaseHelper.tableName_courses,
      {
        CentralDatabaseHelper.code: 'Y_$yearNum',
        CentralDatabaseHelper.year: yearNum,
        CentralDatabaseHelper.units: units,
        CentralDatabaseHelper.qpi: qpi,
        CentralDatabaseHelper.isIncludedInQPI: 1,
      },
      where:
          '${CentralDatabaseHelper.code} = ?', // , ${CentralDatabaseHelper.year} = ?, ${CentralDatabaseHelper.units} = ?, ${CentralDatabaseHelper.qpi} = ?',
      whereArgs: [
        'Y_${year.yearNum}',
        // year.yearNum,
        // year.units,
        // year.yearlyQPI,
      ],
    );

    print('updated $updated from year');

    _updateList();
  }

  void deleteYearlyQPI(int yearNum) async {
    if (kIsWeb) {
      for (Year y in _years) {
        if (y.yearNum == yearNum) {
          _years.remove(y);

          _updateList();
          return;
        }
      }
    }

    int deleted = await (await CentralDatabaseHelper.instance.database).delete(
      CentralDatabaseHelper.tableName_courses,
      where: '${CentralDatabaseHelper.code} = ?',
      whereArgs: ['Y_$yearNum'],
    );

    print('deleted $deleted from year');

    _updateList();
  }

  void addSemestralQPI(int yearNum, int semNum, int units, double qpi) async {
    if (kIsWeb) {
      bool foundYear = false;
      Semester newSem = Semester.fromSem(semNum, units, qpi);

      for (Year y in _years) {
        if (y.yearNum == yearNum) {
          foundYear = true;
          y.sems.add(newSem);
          break;
        }
      }

      if (!foundYear) _years.add(Year(yearNum, [newSem]));

      _updateList();
      return;
    }

    int id = await (await CentralDatabaseHelper.instance.database).insert(
      CentralDatabaseHelper.tableName_courses,
      {
        CentralDatabaseHelper.code: 'S_${yearNum}_$semNum',
        CentralDatabaseHelper.year: yearNum,
        CentralDatabaseHelper.sem: semNum,
        CentralDatabaseHelper.units: units,
        CentralDatabaseHelper.qpi: qpi,
        CentralDatabaseHelper.isIncludedInQPI: 1,
      },
    );

    print('added sem qpi, id: $id');

    _updateList();
  }

  void editSemestralQPI(
    int oldYearNum,
    Semester sem,
    int newYearNum,
    int newSemNum,
    int units,
    double qpi,
  ) async {
    if (kIsWeb) {
      for (Year y in _years) {
        if (y.yearNum == oldYearNum) {
          for (Semester s in y.sems) {
            if (s.semNum == sem.semNum) {
              // for web, the yearnum and semnum aren't updated for now
              s.units = units;
              s.qpi = qpi;
            }
          }
        }
      }

      _updateList();
      return;
    }

    int updated = await (await CentralDatabaseHelper.instance.database).update(
      CentralDatabaseHelper.tableName_courses,
      {
        CentralDatabaseHelper.code: 'S_${newYearNum}_$newSemNum',
        CentralDatabaseHelper.year: newYearNum,
        CentralDatabaseHelper.sem: newSemNum,
        CentralDatabaseHelper.units: units,
        CentralDatabaseHelper.qpi: qpi,
        CentralDatabaseHelper.isIncludedInQPI: 1,
      },
      where:
          '${CentralDatabaseHelper.code} = ?', // , ${CentralDatabaseHelper.year} = ?, ${CentralDatabaseHelper.sem} = ?, ${CentralDatabaseHelper.units} = ?, ${CentralDatabaseHelper.qpi} = ?',
      whereArgs: [
        'S_${oldYearNum}_${sem.semNum}',
        // oldYearNum,
        // sem.semNum,
        // sem.units,
        // sem.semestralQPI,
      ],
    );

    print('updated $updated from sem');

    _updateList();
  }

  void deleteSemestralQPI(int yearNum, int semNum) async {
    if (kIsWeb) {
      for (Year y in _years) {
        if (y.yearNum == yearNum) {
          for (Semester s in y.sems) {
            if (s.semNum == semNum) {
              y.sems.remove(s);

              _updateList();
              return;
            }
          }
        }
      }
    }

    int deleted = await (await CentralDatabaseHelper.instance.database).delete(
      CentralDatabaseHelper.tableName_courses,
      where: '${CentralDatabaseHelper.code} = ?',
      whereArgs: ['S_${yearNum}_$semNum'],
    );

    print('deleted $deleted from sem');

    _updateList();
  }

  void addCourse(
    int yearNum,
    int semNum,
    String code,
    int color,
    int units,
    double qpi,
    bool isIncludedInQPI,
  ) async {
    if (kIsWeb) {
      bool foundYear = false;
      Course newCourse = Course(0, code, color, units, qpi, isIncludedInQPI);

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
    int id,
    int oldYearNum,
    int oldSemNum,
    Course course,
    int newYearNum,
    int newSemNum,
    String code,
    int color,
    int units,
    double qpi,
    bool isIncludedInQPI,
  ) async {
    if (kIsWeb) {
      for (Year y in _years) {
        for (Semester s in y.sems) {
          for (Course c in s.courses) {
            if (c.courseCode == course.courseCode) {
              // for web, yearnum and semnum not updated
              c.courseCode = code;
              c.units = units;
              c.qpi = qpi;
              c.color = Color(color);
              c.isIncludedInQPI = isIncludedInQPI;

              _updateList();
              return;
            }
          }
        }
      }
    }

    int updated = await (await CentralDatabaseHelper.instance.database).update(
      CentralDatabaseHelper.tableName_courses,
      {
        CentralDatabaseHelper.id: id,
        CentralDatabaseHelper.code: code,
        CentralDatabaseHelper.year: newYearNum,
        CentralDatabaseHelper.sem: newSemNum,
        CentralDatabaseHelper.color: color,
        CentralDatabaseHelper.units: units,
        CentralDatabaseHelper.qpi: qpi,
        CentralDatabaseHelper.isIncludedInQPI: (isIncludedInQPI ? 1 : 0),
      },
      where:
          '${CentralDatabaseHelper.id} = ? AND ${CentralDatabaseHelper.year} = ? AND ${CentralDatabaseHelper.sem} = ? AND ${CentralDatabaseHelper.code} = ?',
      whereArgs: [
        id,
        oldYearNum,
        oldSemNum,
        course.courseCode,
      ],
    );

    print('updated $updated from course');

    _updateList();
  }

  void deleteCourse(int id, int yearNum, int semNum, String code) async {
    if (kIsWeb) {
      for (Year y in _years) {
        if (y.yearNum == yearNum) {
          for (Semester s in y.sems) {
            if (s.semNum == semNum) {
              for (Course c in s.courses) {
                if (c.courseCode == code) {
                  s.courses.remove(c);

                  _updateList();
                  return;
                }
              }
            }
          }
        }
      }
    }

    int deleted = await (await CentralDatabaseHelper.instance.database).delete(
      CentralDatabaseHelper.tableName_courses,
      where:
          '${CentralDatabaseHelper.id} = ? AND ${CentralDatabaseHelper.year} = ? AND ${CentralDatabaseHelper.sem} = ? AND ${CentralDatabaseHelper.code} = ?',
      whereArgs: [
        id,
        yearNum,
        semNum,
        code,
      ],
    );

    print('deleted $deleted course');

    _updateList();
  }

  void _sortAll() {
    // sort years
    _years.sort((a, b) => a.yearNum.compareTo(b.yearNum));

    for (Year y in _years) {
      // sort sems
      if (y.sems.length > 0) {
        y.sems.sort((a, b) => a.semNum.compareTo(b.semNum));
        for (Semester s in y.sems) {
          // sort courses
          if (s.courses.length > 0) {
            s.courses.sort((a, b) => a.courseCode.compareTo(b.courseCode));
          }
        }
      }
    }
  }

  void _updateList() async {
    if (kIsWeb) {
      _sortAll();
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

    _sortAll();

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

    await CentralDatabaseHelper.instance.createCoursesTable(
      await CentralDatabaseHelper.instance.database,
      0,
    );

    print('deleted and recreated all course data');
    _updateList();
  }
}
