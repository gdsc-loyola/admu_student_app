import 'package:flutter/material.dart';

import 'package:admu_student_app/models/central_database.dart';

class Subject {
  int id;
  String code;
  String section;
  int yearNum;
  int semNum;
  int qtrNum;
  Color color;
  List<bool> days;
  int start;
  int end;
  bool inEnlistment;
  String profName;

  bool selectedInEnlistment = false;

  Subject(
    int id,
    String code,
    String section,
    int yearNum,
    int semNum,
    int qtrNum,
    int color,
    int days,
    int start,
    int end,
    int inEnlistment,
    String profName,
  ) {
    this.id = id;
    this.code = code;
    this.section = section;
    this.yearNum = yearNum;
    this.semNum = semNum;
    this.qtrNum = qtrNum;
    this.color = Color(color);

    this.days = [];
    String instr = days.toString().padLeft(6, '0');
    for (int i = 0; i < 6; i++) this.days.add(instr[i] == '1');

    this.start = start;
    this.end = end;

    this.inEnlistment = inEnlistment == 1;
    this.profName = profName;
  }

  Subject.fromData(
    String code,
    String section,
    int yearNum,
    int semNum,
    int qtrNum,
    Color color,
    List<bool> days,
    TimeOfDay start,
    TimeOfDay end,
    bool inEnlistment,
    String profName,
  ) {
    this.code = code;
    this.section = section;

    this.yearNum = yearNum;
    this.semNum = semNum;
    this.qtrNum = qtrNum;

    this.color = color;
    this.days = days;

    this.start = (start.hour * 100) + (start.minute);
    this.end = (end.hour * 100) + (end.minute);

    this.inEnlistment = inEnlistment;
    this.profName = profName;
  }

  factory Subject.fromMap(Map map) {
    return Subject(
      map[CentralDatabaseHelper.id],
      map[CentralDatabaseHelper.code],
      map[CentralDatabaseHelper.section],
      map[CentralDatabaseHelper.year],
      map[CentralDatabaseHelper.sem],
      map[CentralDatabaseHelper.quarter],
      map[CentralDatabaseHelper.color],
      map[CentralDatabaseHelper.days],
      map[CentralDatabaseHelper.start],
      map[CentralDatabaseHelper.end],
      map[CentralDatabaseHelper.inEnlistment],
      map[CentralDatabaseHelper.professor],
    );
  }

  String getReadableStartTime() {
    int hour = start ~/ 100;
    int minute = start % 100;

    return (hour < 12 ? (hour == 0 ? 12 : hour) : hour - 12)
            .toString()
            .padLeft(2, '0') +
        ':' +
        minute.toString().padLeft(2, '0') +
        (hour < 12 ? ' AM' : ' PM');
  }

  String getReadableEndTime() {
    int hour = end ~/ 100;
    int minute = end % 100;

    return (hour < 12 ? (hour == 0 ? 12 : hour) : hour - 12)
            .toString()
            .padLeft(2, '0') +
        ':' +
        minute.toString().padLeft(2, '0') +
        (hour < 12 ? ' AM' : ' PM');
  }
}
