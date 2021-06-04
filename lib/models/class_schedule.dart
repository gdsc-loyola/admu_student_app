import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/central_database.dart';
import 'package:admu_student_app/models/subject.dart';

class ClassSchedule extends ChangeNotifier {
  final List<Subject> _sampleData = [
    Subject('CSCI 20', 1, 1, 1, AppColors.ACCENTS[0].value, 101010, 1300, 1400),
    Subject('CSCI 21', 1, 1, 0, AppColors.ACCENTS[1].value, 010100, 0900, 1100),
    Subject('ENGL 11', 1, 1, 1, AppColors.ACCENTS[2].value, 101010, 1400, 1500),
    Subject('MATH 10', 1, 1, 1, AppColors.ACCENTS[3].value, 010100, 1230, 1400),
    Subject(
        'INTACT 11', 1, 1, 0, AppColors.ACCENTS[4].value, 100000, 1000, 1100),
    Subject('FILI 12', 1, 1, 2, AppColors.ACCENTS[0].value, 010100, 1230, 1400),
    Subject('MATH 21', 1, 1, 2, AppColors.ACCENTS[1].value, 101010, 1300, 1400),
    Subject(
        'PHYED 111', 1, 1, 1, AppColors.ACCENTS[2].value, 010100, 1400, 1500),
    Subject(
        'SocSc 11', 1, 2, 3, AppColors.ACCENTS[0].value, 101010, 0900, 1000),
    Subject(
        'INTACT 12', 1, 2, 0, AppColors.ACCENTS[1].value, 100000, 1000, 1100),
    Subject('THEO 11', 1, 2, 3, AppColors.ACCENTS[2].value, 101010, 1100, 1200),
    Subject('CSCI 22', 1, 2, 0, AppColors.ACCENTS[3].value, 010100, 0900, 1100),
    Subject(
        'MATH 30.23', 1, 2, 0, AppColors.ACCENTS[4].value, 010100, 1230, 1400),
    Subject('FILI 11', 1, 2, 3, AppColors.ACCENTS[0].value, 010100, 1400, 1530),
    Subject(
        'HISTO 11', 1, 2, 4, AppColors.ACCENTS[1].value, 101010, 0900, 1000),
    Subject(
        'PHYED 143', 1, 2, 4, AppColors.ACCENTS[2].value, 101010, 1300, 1400),
    Subject(
        'ENLIT 12', 1, 2, 4, AppColors.ACCENTS[3].value, 101010, 1400, 1500),
    Subject(
        'CSCI 152', 2, 0, 0, AppColors.ACCENTS[0].value, 101010, 1400, 1500),
  ];
  List<Subject> _subjects = [];

  List<String> getScheduleNames() {
    return [];
  }

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

  ClassSchedule() {
    if (kIsWeb) {
      _subjects.addAll(_sampleData);
    }

    notifyListeners();
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

  void addSubject() async {
    if (kIsWeb) {
      //
      _updateList();
      return;
    }

    // add in database

    _updateList();
  }

  void editSubject() async {
    if (kIsWeb) {
      //
      _updateList();
      return;
    }

    // edit in database

    _updateList();
  }

  void deleteSubject() async {
    if (kIsWeb) {
      //
      _updateList();
      return;
    }

    // delete in database

    _updateList();
  }

  void _updateList() async {
    if (kIsWeb) {
      //
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
