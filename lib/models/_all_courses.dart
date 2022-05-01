import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/central_database.dart';
import 'package:admu_student_app/models/_course.dart';
import 'package:admu_student_app/models/_semester.dart';
import 'package:admu_student_app/models/_year.dart';
import 'package:sqflite/sqflite.dart';

class AllCourses extends ChangeNotifier {
  final List<Year> _sampleData = [
    Year(
      1,
      [
        Semester.fromSem(1, 18, 3.75),
        Semester.fromSem(2, 21, 75 / 21),
        // Semester(
        //   2,
        //   [
        //     Course(0, 'CSCI 22', '', AppColors.ACCENTS[0].value, 010100, 0900,
        //         1100, 0, '', '', 3, 4.0, true),
        //     Course(0, 'ENLIT 12', '', AppColors.ACCENTS[1].value, 101010, 1400,
        //         1500, 0, '', '', 3, 4.0, true),
        //     Course(0, 'FILI 11', '', AppColors.ACCENTS[2].value, 010100, 1400,
        //         1530, 0, '', '', 3, 4.0, true),
        //     Course(0, 'HISTO 11', '', AppColors.ACCENTS[3].value, 101010, 0900,
        //         1000, 0, '', '', 3, 4.0, true),
        //     Course(0, 'INTACT 12', '', AppColors.ACCENTS[4].value, 100000, 1000,
        //         1100, 0, '', '', 0, 0.0, false),
        //     Course(0, 'MATH 30.23', '', AppColors.ACCENTS[0].value, 010100,
        //         1230, 1400, 0, '', '', 3, 4.0, false),
        //     Course(0, 'PHYED 143', '', AppColors.ACCENTS[1].value, 101000, 1300,
        //         1400, 0, '', '', 2, 4.0, false),
        //     Course(0, 'SocSc 11', '', AppColors.ACCENTS[2].value, 101010, 0900,
        //         1000, 0, '', '', 3, 4.0, false),
        //     Course(0, 'THEO 11', '', AppColors.ACCENTS[3].value, 101010, 1100,
        //         1200, 0, '', '', 3, 4.0, false),
        //   ],
        // ),
      ],
    ),
    Year(
      2,
      [
        Semester.fromSem(0, 9, 3.50),
        Semester(
          1,
          [
            Course(0, 2, 1, 'ArtAp 10', '', AppColors.ACCENTS[0].value, 101010,
                0900, 1000, 0, '', '', 3, 4.0, true),
            Course(0, 2, 1, 'CSCI 30', '', AppColors.ACCENTS[1].value, 010100,
                1100, 1230, 0, '', '', 3, 4.0, true),
            Course(0, 2, 1, 'MATH 30.24', '', AppColors.ACCENTS[2].value,
                010100, 1530, 1700, 0, '', '', 4, 3.5, true),
            Course(0, 2, 1, 'MATH 51.3', '', AppColors.ACCENTS[3].value, 101010,
                0800, 0900, 0, '', '', 3, 4.0, true),
            Course(0, 2, 1, 'PHILO 11.04', '', AppColors.ACCENTS[4].value,
                010100, 1400, 1530, 0, '', '', 3, 3.5, true),
            Course(0, 2, 1, 'PHYED 161', '', AppColors.ACCENTS[0].value, 010100,
                0900, 1000, 0, '', '', 2, 4.0, false),
            Course(0, 2, 1, 'PHYS 23.11', '', AppColors.ACCENTS[1].value,
                101010, 1100, 1200, 0, '', '', 3, 3.5, true),
            Course(0, 2, 1, 'PHYS 23.12', '', AppColors.ACCENTS[2].value,
                001010, 1300, 1500, 0, '', '', 2, 4.0, true),
          ],
        ),
        Semester(
          2,
          [
            Course(0, 2, 2, 'CSCI 40', '', AppColors.ACCENTS[0].value, 101010,
                1400, 1500, 0, '', '', 3, 4.0, true),
            Course(0, 2, 2, 'HISTO 12', '', AppColors.ACCENTS[1].value, 101010,
                1500, 1600, 0, '', '', 3, 4.0, true),
            Course(0, 2, 2, 'JPN 11', '', AppColors.ACCENTS[2].value, 010100,
                1400, 1530, 0, '', '', 3, 4.0, true),
            Course(0, 2, 2, 'MATH 51.4', '', AppColors.ACCENTS[3].value, 010100,
                1100, 1230, 0, '', '', 3, 4.0, true),
            Course(0, 2, 2, 'NSTP 11', '', AppColors.ACCENTS[4].value, 000001,
                1400, 1700, 0, '', '', 3, 4.0, false),
            Course(0, 2, 2, 'PHYED 145', '', AppColors.ACCENTS[0].value, 101000,
                1600, 1700, 0, '', '', 2, 4.0, false),
            Course(0, 2, 2, 'PHYS 160', '', AppColors.ACCENTS[1].value, 010110,
                0800, 0900, 0, '', '', 5, 4.0, true),
            Course(0, 2, 2, 'THEO 12', '', AppColors.ACCENTS[2].value, 010100,
                1230, 1400, 0, '', '', 3, 4.0, true),
          ],
        ),
      ],
    ),
  ];

  List<Year> _years = [];

  // getter for years
  get years => _years;

  // default constructor
  AllCourses() {
    if (kIsWeb) _years.addAll(_sampleData);

    _updateList();
  }

  // get courses from specific year and semester
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

    // if not found
    return [];
  }

  // getter for cumulative qpi
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

  // get specific year
  Year getYear(int yearNum) {
    for (Year y in _years) {
      if (y.yearNum == yearNum) return y;
    }

    return null;
  }

  // get specific semester from year
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

  // get semestral qpi of specific year and sem
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

  // add yearly qpi
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
    } else {
      int id = await (await CentralDatabaseHelper.instance.database).insert(
        CentralDatabaseHelper.tableName_courses,
        {
          CentralDatabaseHelper.year: yearNum,
          CentralDatabaseHelper.code: 'Y_$yearNum',
          CentralDatabaseHelper.units: units,
          CentralDatabaseHelper.qpi: qpi,
          CentralDatabaseHelper.isIncludedInQPI: 1,
        },
      );

      print('added yearly qpi, id: $id');
    }
    _updateList();
  }

  // edit yearly qpi
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
    } else {
      int updated =
          await (await CentralDatabaseHelper.instance.database).update(
        CentralDatabaseHelper.tableName_courses,
        {
          CentralDatabaseHelper.year: yearNum,
          CentralDatabaseHelper.code: 'Y_$yearNum',
          CentralDatabaseHelper.units: units,
          CentralDatabaseHelper.qpi: qpi,
          CentralDatabaseHelper.isIncludedInQPI: 1,
        },
        where: '${CentralDatabaseHelper.code} = ?',
        whereArgs: ['Y_${year.yearNum}'],
      );

      print('updated $updated from year');

      _updateList();
    }
  }

  // delete yearly qpi
  void deleteYearlyQPI(int yearNum) async {
    if (kIsWeb) {
      for (Year y in _years) {
        if (y.yearNum == yearNum) {
          _years.remove(y);

          _updateList();
          return;
        }
      }
    } else {
      int deleted =
          await (await CentralDatabaseHelper.instance.database).delete(
        CentralDatabaseHelper.tableName_courses,
        where: '${CentralDatabaseHelper.code} = ?',
        whereArgs: ['Y_$yearNum'],
      );

      print('deleted $deleted from year');

      _updateList();
    }
  }

  // add semestral qpi
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
    } else {
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
    }
    _updateList();
  }

  // edit semestral qpi
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
    } else {
      int updated =
          await (await CentralDatabaseHelper.instance.database).update(
        CentralDatabaseHelper.tableName_courses,
        {
          CentralDatabaseHelper.code: 'S_${newYearNum}_$newSemNum',
          CentralDatabaseHelper.year: newYearNum,
          CentralDatabaseHelper.sem: newSemNum,
          CentralDatabaseHelper.units: units,
          CentralDatabaseHelper.qpi: qpi,
          CentralDatabaseHelper.isIncludedInQPI: 1,
        },
        where: '${CentralDatabaseHelper.code} = ?',
        whereArgs: ['S_${oldYearNum}_${sem.semNum}'],
      );

      print('updated $updated from sem');
    }
    _updateList();
  }

  // delete semestral qpi
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
    } else {
      int deleted =
          await (await CentralDatabaseHelper.instance.database).delete(
        CentralDatabaseHelper.tableName_courses,
        where: '${CentralDatabaseHelper.code} = ?',
        whereArgs: ['S_${yearNum}_$semNum'],
      );

      print('deleted $deleted from sem');

      _updateList();
    }
  }

  // add course
  void addCourse(
    int yearNum,
    int semNum,
    String code,
    String section,
    int color,
    List<bool> days,
    TimeOfDay startTime,
    TimeOfDay endTime,
    bool inEnlistment,
    String profName,
    String notes,
    int units,
    double qpi,
    bool isIncludedInQPI,
  ) async {
    // convert days to string
    String daysInStr = '';
    for (int i = 0; i < days.length; i++) daysInStr += days[i] ? '1' : '0';
    daysInStr = daysInStr.padRight(6, '0');

    if (kIsWeb) {
      bool foundYear = false;
      Course newCourse = Course(
        0,
        yearNum,
        semNum,
        code,
        section,
        color,
        int.parse(daysInStr),
        (startTime.hour * 100) + startTime.minute,
        (endTime.hour * 100) + endTime.minute,
        inEnlistment ? 1 : 0,
        profName,
        notes,
        units,
        qpi,
        isIncludedInQPI,
      );

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

      if (!foundYear) {
        _years.add(Year(yearNum, [
          Semester(semNum, [newCourse])
        ]));
      }
    } else {
      int id = await (await CentralDatabaseHelper.instance.database).insert(
        CentralDatabaseHelper.tableName_courses,
        {
          CentralDatabaseHelper.year: yearNum,
          CentralDatabaseHelper.sem: semNum,
          CentralDatabaseHelper.code: code,
          CentralDatabaseHelper.section: section,
          CentralDatabaseHelper.color: color,
          CentralDatabaseHelper.days: int.parse(daysInStr),
          CentralDatabaseHelper.start:
              (startTime.hour * 100) + startTime.minute,
          CentralDatabaseHelper.end: (endTime.hour * 100) + endTime.minute,
          CentralDatabaseHelper.inEnlistment: inEnlistment ? 1 : 0,
          CentralDatabaseHelper.professor: profName,
          CentralDatabaseHelper.notes: notes,
          CentralDatabaseHelper.units: units,
          CentralDatabaseHelper.qpi: qpi,
          CentralDatabaseHelper.isIncludedInQPI: isIncludedInQPI ? 1 : 0,
        },
      );

      print('added new course, id: $id');
    }
    _updateList();
  }

  // edit course
  void editCourse(
    int id,
    int oldYearNum,
    int oldSemNum,
    String oldCode,
    int yearNum,
    int semNum,
    String code,
    String section,
    int color,
    List<bool> days,
    TimeOfDay startTime,
    TimeOfDay endTime,
    bool inEnlistment,
    String profName,
    String notes,
    int units,
    double qpi,
    bool isIncludedInQPI,
  ) async {
    if (kIsWeb) {
      for (Year y in _years) {
        for (Semester s in y.sems) {
          for (Course c in s.courses) {
            if (c.code == oldCode) {
              // for web, yearnum and semnum not updated
              c.code = code;
              c.section = section;

              c.color = Color(color);
              c.days = days;
              c.start = (startTime.hour * 100) + startTime.minute;
              c.end = (endTime.hour * 100) + endTime.minute;

              c.inEnlistment = inEnlistment;
              c.profName = profName;
              c.notes = notes;

              c.units = units;
              c.qpi = qpi;
              c.isIncludedInQPI = isIncludedInQPI;

              _updateList();
              return;
            }
          }
        }
      }
    } else {
      String daysInStr = '';
      for (int i = 0; i < days.length; i++) daysInStr += days[i] ? '1' : '0';
      daysInStr = daysInStr.padRight(6, '0');

      int updated =
          await (await CentralDatabaseHelper.instance.database).update(
        CentralDatabaseHelper.tableName_courses,
        {
          CentralDatabaseHelper.id: id,
          CentralDatabaseHelper.year: yearNum,
          CentralDatabaseHelper.sem: semNum,
          CentralDatabaseHelper.code: code,
          CentralDatabaseHelper.section: section,
          CentralDatabaseHelper.color: color,
          CentralDatabaseHelper.days: int.parse(daysInStr),
          CentralDatabaseHelper.start:
              (startTime.hour * 100) + startTime.minute,
          CentralDatabaseHelper.end: (endTime.hour * 100) + endTime.minute,
          CentralDatabaseHelper.inEnlistment: inEnlistment ? 1 : 0,
          CentralDatabaseHelper.professor: profName,
          CentralDatabaseHelper.notes: notes,
          CentralDatabaseHelper.units: units,
          CentralDatabaseHelper.qpi: qpi,
          CentralDatabaseHelper.isIncludedInQPI: isIncludedInQPI ? 1 : 0,
        },
        where:
            '${CentralDatabaseHelper.id} = ? AND ${CentralDatabaseHelper.year} = ? AND ${CentralDatabaseHelper.sem} = ? AND ${CentralDatabaseHelper.code} = ?',
        whereArgs: [
          id,
          oldYearNum,
          oldSemNum,
          oldCode,
        ],
      );

      print('updated $updated from course');

      _updateList();
    }
  }

  // delete course
  void deleteCourse(int id, int yearNum, int semNum, String code) async {
    if (kIsWeb) {
      for (Year y in _years) {
        if (y.yearNum == yearNum) {
          for (Semester s in y.sems) {
            if (s.semNum == semNum) {
              for (Course c in s.courses) {
                if (c.code == code) {
                  s.courses.remove(c);

                  _updateList();
                  return;
                }
              }
            }
          }
        }
      }
    } else {
      int deleted =
          await (await CentralDatabaseHelper.instance.database).delete(
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
  }

  // sort internal lists
  void _sortAll() {
    _years.sort((a, b) => a.yearNum.compareTo(b.yearNum));

    for (Year y in _years) {
      if (y.sems.length > 0) {
        y.sems.sort((a, b) => a.semNum.compareTo(b.semNum));

        for (Semester s in y.sems) {
          if (s.courses.length > 0) {
            s.courses.sort((a, b) => a.code.compareTo(b.code));
          }
        }
      }
    }
  }

  // get data of subjects
  // TODO edit?
  Map<String, dynamic> getSubjects(int yearNum, int semNum, int qtrNum,
      [List<Course> subjs]) {
    List<List<Course>> data = [[], [], [], [], [], []];

    int start = 24;
    int end = 00;

    bool isEmpty = true;

    if (subjs == null) {
      for (Year y in _years) {
        if (y.yearNum == yearNum) {
          for (Semester s in y.sems) {
            if (s.semNum == semNum) {
              for (Course c in s.courses) {
                if (c.inEnlistment) continue;

                // check schedule
                for (int i = 0; i < data.length; i++) {
                  if (c.days[i]) {
                    data[i].add(c); // add reference
                    isEmpty = false;
                  }
                }

                // if earlier than start
                if (c.start < start * 100) start = (c.start / 100).floor();

                // if later than end
                if (c.end > end * 100) end = (c.end / 100).ceil();
              }
            }
          }
        }
      }
    } else {
      for (Course s in subjs) {
        // check schedule
        for (int i = 0; i < data.length; i++) {
          if (s.days[i]) {
            data[i].add(s); // add reference
            isEmpty = false;
          }
        }

        // if earlier than start
        if (s.start < start * 100) start = (s.start / 100).floor();

        // if later than end
        if (s.end > end * 100) end = (s.end / 100).ceil();
      }
    }

    // sort each list by starting hour
    for (int i = 0; i < data.length; i++) {
      data[i].sort((a, b) => a.start.compareTo(b.start));

      for (int j = data[i].length - 1; j > 0; j--) {
        if (data[i][j].start < data[i][j - 1].end) data[i].removeAt(j);
      }
    }

    return {
      'start': start == 24 ? 7 : start, // floor
      'end': end == 0 ? 17 : end, // ceil
      'subjects': data,
      'isEmpty': isEmpty,
    };
  }

  // get latest schedule details
  Map<String, int> getLatestScheduleDetails() {
    int yr = 0;
    int sem = 0;

    bool found = false;
    for (int i = _years.length - 1; i >= 0; i--) {
      for (int j = _years[i].sems.length - 1; j >= 0; j--) {
        for (Course c in _years[i].sems[j].courses) {
          if (!c.inEnlistment) {
            yr = _years[i].yearNum;
            sem = _years[i].sems[j].semNum;
            found = true;
          }
          if (found) break;
        }
        if (found) break;
      }
      if (found) break;
    }

    return {
      'yearNum': yr,
      'semNum': sem,
      'q': 0,
    };
  }

  // get enlistment schedule latest details
  Map<String, int> getEnlistmentScheduleDetails() {
    int yr = 0;
    int sem = 0;

    bool found = false;
    for (int i = _years.length - 1; i >= 0; i--) {
      for (int j = _years[i].sems.length - 1; j >= 0; j--) {
        for (Course c in _years[i].sems[j].courses) {
          if (c.inEnlistment) {
            yr = _years[i].yearNum;
            sem = _years[i].sems[j].semNum;
            found = true;
          }
          if (found) break;
        }
        if (found) break;
      }
      if (found) break;
    }

    return {
      'yearNum': yr,
      'semNum': sem,
      'q': 0,
    };
  }

  // get enlistment subjects
  List<Map<String, dynamic>> getEnlistmentSubjects() {
    List<Map<String, dynamic>> grouped = [];
    List<Course> raw = [];

    for (Year y in _years) {
      for (Semester s in y.sems) {
        for (Course c in s.courses) {
          if (c.inEnlistment) {
            raw.add(c);
          }
        }
      }
    }

    raw.sort((a, b) => a.code.toLowerCase().compareTo(b.code.toLowerCase()));

    // code, subjects
    raw.forEach((sub) {
      bool hasGroup = false;
      for (Map m in grouped) {
        if (m['code'].toLowerCase() == sub.code.toLowerCase()) {
          hasGroup = true;
          m['subjects'].add(sub);
          break;
        }
      }

      if (!hasGroup) {
        grouped.add({
          'color': sub.color,
          'code': sub.code,
          'subjects': [sub],
        });
      }
    });

    return grouped;
  }

  // add enlistment subjects to schedule
  void addEnlistmentSchedule() async {
    int updated = 0;

    Database db;
    if (!kIsWeb) db = await CentralDatabaseHelper.instance.database;

    // add selected to full list
    for (Year y in _years) {
      for (Semester s in y.sems) {
        for (Course c in s.courses) {
          if (c.inEnlistment && c.selectedInEnlistment) {
            if (kIsWeb) {
              c.inEnlistment = false;
            } else {
              String daysInStr = '';
              for (int i = 0; i < c.days.length; i++)
                daysInStr += c.days[i] ? '1' : '0';
              daysInStr = daysInStr.padRight(6, '0');

              updated += await db.update(
                CentralDatabaseHelper.tableName_courses,
                {
                  CentralDatabaseHelper.id: c.id,
                  CentralDatabaseHelper.year: y.yearNum,
                  CentralDatabaseHelper.sem: s.semNum,
                  CentralDatabaseHelper.code: c.code,
                  CentralDatabaseHelper.section: c.section,
                  CentralDatabaseHelper.color: c.color,
                  CentralDatabaseHelper.days: daysInStr,
                  CentralDatabaseHelper.start: c.start,
                  CentralDatabaseHelper.end: c.end,
                  CentralDatabaseHelper.inEnlistment: 0,
                  CentralDatabaseHelper.professor: c.profName,
                  CentralDatabaseHelper.notes: c.notes,
                  CentralDatabaseHelper.units: c.units,
                  CentralDatabaseHelper.qpi: c.qpi,
                  CentralDatabaseHelper.isIncludedInQPI:
                      c.isIncludedInQPI ? 1 : 0,
                },
                where:
                    '${CentralDatabaseHelper.year} = ? AND ${CentralDatabaseHelper.sem} = ? AND ${CentralDatabaseHelper.code} = ? AND ${CentralDatabaseHelper.section} = ? AND ${CentralDatabaseHelper.inEnlistment} = ?',
                whereArgs: [
                  y.yearNum,
                  s.semNum,
                  c.code,
                  c.section,
                  1,
                ],
              );
            }
          }
        }
      }
    }

    int deleted = 0;

    // delete other subjects
    if (kIsWeb) {
      for (Year y in _years) {
        for (Semester s in y.sems) {
          for (int i = s.courses.length - 1; i >= 0; i--) {
            if (s.courses[i].inEnlistment) {
              s.courses.removeAt(i);
            }
          }
        }
      }
    } else {
      deleted = await db.delete(
        CentralDatabaseHelper.tableName_courses,
        where: '${CentralDatabaseHelper.inEnlistment} = ?',
        whereArgs: [1],
      );
    }

    print('updated $updated, deleted $deleted');

    _updateList();
  }

  static int getMinutesBetween(int time1, int time2) {
    // time1 < time2

    int hr1 = time1 ~/ 100;
    int mn1 = time1 % 100;

    int hr2 = time2 ~/ 100;
    int mn2 = time2 % 100;

    int mins = 0;

    if (mn1 <= mn2) {
      mins = (hr2 - hr1) * 60 + (mn2 - mn1);
    } else {
      mins = (hr2 - hr1 - 1) * 60 + (mn2 + 60 - mn1);
    }

    return mins;
  }

  // update internal list
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
      orderBy: '${CentralDatabaseHelper.year} ASC',
    );

    _years = [];

    // create courses
    tempRows.forEach((row) {
      String code = row[CentralDatabaseHelper.code];

      if (code.startsWith('Y_')) {
        // add year qpi, Y_X
        bool foundYear = false;
        int yearNum = int.parse(code[2]);

        for (Year y in _years) {
          if (y.yearNum == yearNum) {
            foundYear = true;
            y.qpi = row[CentralDatabaseHelper.qpi];
            break;
          }
        }

        if (!foundYear) {
          _years.add(new Year.fromYear(
            yearNum,
            row[CentralDatabaseHelper.units],
            row[CentralDatabaseHelper.qpi],
          ));
        }
      } else if (code.startsWith('S_')) {
        // add sem qpi, S_X_X
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

            if (!foundSem) {
              y.sems.add(newSem);
            }

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

            if (!foundSem) {
              y.sems.add(Semester(semNum, [newCourse]));
            }

            break;
          }
        }

        if (!foundYear) {
          _years.add(Year(yearNum, [
            Semester(semNum, [newCourse])
          ]));
        }
      }
    });

    _sortAll();
    notifyListeners();
  }

  // delete all data
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
