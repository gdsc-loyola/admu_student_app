import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/central_database.dart';
import 'package:admu_student_app/models/subject.dart';

class ClassSchedule extends ChangeNotifier {
  final List<Subject> _sampleData = [
    Subject('CSCI 20', '', 1, 1, 1, AppColors.ACCENTS[0].value, 101010, 1300,
        1400, 0, ''),
    Subject('CSCI 21', '', 1, 1, 0, AppColors.ACCENTS[1].value, 010100, 0900,
        1100, 0, ''),
    Subject('ENGL 11', '', 1, 1, 1, AppColors.ACCENTS[2].value, 101010, 1400,
        1500, 0, ''),
    Subject('MATH 10', '', 1, 1, 1, AppColors.ACCENTS[3].value, 010100, 1230,
        1400, 0, ''),
    Subject('INTACT 11', '', 1, 1, 0, AppColors.ACCENTS[4].value, 100000, 1000,
        1100, 0, ''),
    Subject('FILI 12', '', 1, 1, 2, AppColors.ACCENTS[0].value, 010100, 1230,
        1400, 0, ''),
    Subject('MATH 21', '', 1, 1, 2, AppColors.ACCENTS[1].value, 101010, 1300,
        1400, 0, ''),
    Subject('PHYED 111', '', 1, 1, 1, AppColors.ACCENTS[2].value, 010100, 1400,
        1500, 0, ''),
    Subject('SocSc 11', '', 1, 2, 3, AppColors.ACCENTS[0].value, 101010, 0900,
        1000, 0, ''),
    Subject('INTACT 12', '', 1, 2, 0, AppColors.ACCENTS[1].value, 100000, 1000,
        1100, 0, ''),
    Subject('THEO 11', '', 1, 2, 3, AppColors.ACCENTS[2].value, 101010, 1100,
        1200, 0, ''),
    Subject('CSCI 22', '', 1, 2, 0, AppColors.ACCENTS[3].value, 010100, 0900,
        1100, 0, ''),
    Subject('MATH 30.23', '', 1, 2, 0, AppColors.ACCENTS[4].value, 010100, 1230,
        1400, 0, ''),
    Subject('FILI 11', '', 1, 2, 3, AppColors.ACCENTS[0].value, 010100, 1400,
        1530, 0, ''),
    Subject('HISTO 11', '', 1, 2, 4, AppColors.ACCENTS[1].value, 101010, 0900,
        1000, 0, ''),
    Subject('PHYED 143', '', 1, 2, 4, AppColors.ACCENTS[2].value, 101010, 1300,
        1400, 0, ''),
    Subject('ENLIT 12', '', 1, 2, 4, AppColors.ACCENTS[3].value, 101010, 1400,
        1500, 0, ''),
    Subject('CSCI 152', 'A', 2, 0, 0, AppColors.ACCENTS[0].value, 101010, 1400,
        1500, 1, 'Prof A'),
    Subject('CSCI 152', 'B', 2, 0, 0, AppColors.ACCENTS[0].value, 101010, 1500,
        1600, 1, 'Prof B'),
    Subject('CSCI 152', 'C', 2, 0, 0, AppColors.ACCENTS[0].value, 101010, 1600,
        1700, 1, 'Prof C'),
    Subject('PHYED', 'A', 2, 0, 0, AppColors.ACCENTS[0].value, 101010, 1400,
        1500, 1, 'Prof A'),
    Subject('PHYED', 'B', 2, 0, 0, AppColors.ACCENTS[0].value, 101010, 1500,
        1600, 1, 'Prof B'),
    Subject('PHYED', 'C', 2, 0, 0, AppColors.ACCENTS[0].value, 101010, 1600,
        1700, 1, 'Prof C'),
  ];
  List<Subject> _subjects = [];

  List<Map<String, dynamic>> getSchedules() {
    // schedule name
    // yearnum
    // semnum

    List<Map<String, dynamic>> maps = [];

    // query all subjects and check
    for (Subject s in _subjects) {
      bool found = false;
      for (int i = 0; i < maps.length; i++) {
        if (maps[i]['yearNum'] == s.yearNum && maps[i]['semNum'] == s.semNum) {
          found = true;
          break;
        }
      }

      if (!found) {
        // add
        maps.add({
          'scheduleName': 'YEAR ${s.yearNum}, SEM ${s.semNum}',
          'yearNum': s.yearNum,
          'semNum': s.semNum,
          'qtrNum': 0,
        });
      }
    }

    // maps.sort((a, b) => (a['yearNum'] * 10 + a['semNum'])
    //     .compareTo((b['yearNum'] * 10 + b['semNum'])));

    return maps;
  }

  Map<String, dynamic> getSubjects(int yearNum, int semNum, int qtrNum) {
    List<List<Subject>> data = [[], [], [], [], [], []];

    int start = 24;
    int end = 00;

    for (Subject s in _subjects) {
      if (s.yearNum == yearNum && s.semNum == semNum) {
        if (s.qtrNum == 0 || s.qtrNum == qtrNum) {
          // check schedule
          for (int i = 0; i < data.length; i++) {
            if (s.days[i]) data[i].add(s); // add reference
          }

          // if earlier than start
          if (s.start < start * 100) start = (s.start / 100).floor();

          // if later than end
          if (s.end > end * 100) end = (s.end / 100).ceil();
        }
      }
    }

    // sort each list by starting hour
    for (int i = 0; i < data.length; i++)
      data[i].sort((a, b) => a.start.compareTo(b.start));

    return {
      'start': start == 24 ? 7 : start, // floor
      'end': end == 0 ? 17 : end, // ceil
      'subjects': data,
    };
  }

  List<Map<String, dynamic>> getEnlistmentSubjects() {
    List<Map<String, dynamic>> grouped = [];

    List<Subject> raw = [];

    for (Subject s in _subjects) {
      if (s.inEnlistment) raw.add(s);
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
          'code': sub.code,
          'subjects': [sub],
        });
      }
    });

    return grouped;
  }

  ClassSchedule() {
    if (kIsWeb) {
      _subjects.addAll(_sampleData);
    }

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

  void addSubject(
    String code,
    String section,
    int yearNum,
    int semNum,
    Color color,
    List<bool> days,
    TimeOfDay startTime,
    TimeOfDay endTime,
    bool inEnlistment,
    String profName,
  ) async {
    if (kIsWeb) {
      _subjects.add(Subject.fromData(
        code,
        section,
        yearNum,
        semNum,
        0,
        color,
        days,
        startTime,
        endTime,
        inEnlistment,
        profName,
      ));

      _updateList();
      return;
    }

    String daysInStr = '';
    for (int i = 0; i < days.length; i++) daysInStr += days[i] ? '1' : '0';
    daysInStr = daysInStr.padRight(6, '0');

    // add in database
    int id = await (await CentralDatabaseHelper.instance.database).insert(
      CentralDatabaseHelper.tableName_schedule,
      {
        CentralDatabaseHelper.code: code,
        CentralDatabaseHelper.section: section,
        CentralDatabaseHelper.year: yearNum,
        CentralDatabaseHelper.sem: semNum,
        CentralDatabaseHelper.quarter: 0,
        CentralDatabaseHelper.color: color.value,
        CentralDatabaseHelper.days: int.parse(daysInStr),
        CentralDatabaseHelper.start: (startTime.hour * 100) + startTime.minute,
        CentralDatabaseHelper.end: (endTime.hour * 100) + endTime.minute,
        CentralDatabaseHelper.inEnlistment: inEnlistment ? 1 : 0,
        CentralDatabaseHelper.professor: profName,
      },
    );

    print('added schedule, id: $id');

    _updateList();
  }

  void editSubject(
    Subject subj,
    String code,
    String section,
    int yearNum,
    int semNum,
    Color color,
    List<bool> days,
    TimeOfDay startTime,
    TimeOfDay endTime,
    bool inEnlistment,
    String profName,
  ) async {
    if (kIsWeb) {
      for (Subject s in _subjects) {
        if (s.yearNum == subj.yearNum &&
            s.semNum == subj.semNum &&
            s.code == subj.code) {
          s.code = code;
          s.section = section;
          s.yearNum = yearNum;
          s.semNum = semNum;

          s.color = color;
          s.days = days;

          s.start = (startTime.hour * 100) + startTime.minute;
          s.end = (endTime.hour * 100) + endTime.minute;

          s.inEnlistment = inEnlistment;
          s.profName = profName;

          _updateList();
          return;
        }
      }
    }

    String daysInStr = '';
    for (int i = 0; i < days.length; i++) daysInStr += days[i] ? '1' : '0';
    daysInStr = daysInStr.padRight(6, '0');

    // edit in database
    int updated = await (await CentralDatabaseHelper.instance.database).update(
      CentralDatabaseHelper.tableName_schedule,
      {
        CentralDatabaseHelper.code: code,
        CentralDatabaseHelper.section: section,
        CentralDatabaseHelper.year: yearNum,
        CentralDatabaseHelper.sem: semNum,
        CentralDatabaseHelper.quarter: 0,
        CentralDatabaseHelper.color: color.value,
        CentralDatabaseHelper.days: int.parse(daysInStr),
        CentralDatabaseHelper.start: (startTime.hour * 100) + startTime.minute,
        CentralDatabaseHelper.end: (endTime.hour * 100) + endTime.minute,
        CentralDatabaseHelper.inEnlistment: inEnlistment ? 1 : 0,
        CentralDatabaseHelper.professor: profName,
      },
      where: '',
      whereArgs: [],
    );

    print('updated $updated in schedule');

    _updateList();
  }

  void deleteSubject(Subject subj) async {
    if (kIsWeb) {
      for (Subject s in _subjects) {
        if (s == subj) {
          _subjects.remove(s);

          _updateList();
          return;
        }
      }
    }

    // delete in database
    int deleted = await (await CentralDatabaseHelper.instance.database).delete(
      CentralDatabaseHelper.tableName_schedule,
      where:
          '${CentralDatabaseHelper.year} = ? AND ${CentralDatabaseHelper.sem} = ? AND ${CentralDatabaseHelper.code} = ?',
      whereArgs: [subj.yearNum, subj.semNum, subj.code],
    );

    print('deleted $deleted in schedule');

    _updateList();
  }

  void _updateList() async {
    if (kIsWeb) {
      notifyListeners();

      return;
    }

    // rebuild inner data

    _subjects = [];

    List<Map<String, dynamic>> rows =
        await (await CentralDatabaseHelper.instance.database).query(
            CentralDatabaseHelper.tableName_schedule,
            orderBy: '${CentralDatabaseHelper.year} ASC');

    rows.forEach((row) {
      _subjects.add(Subject.fromMap(row));
    });

    notifyListeners();
  }
}
