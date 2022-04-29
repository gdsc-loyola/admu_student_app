import 'package:flutter/material.dart';

import 'package:admu_student_app/models/central_database.dart';

class Course {
  int id;

  // int yearNum;
  // int semNum;

  String code;
  String section;
  Color color;

  List<bool> days;
  int start;
  int end;

  bool inEnlistment;
  String profName;
  String notes;

  int units;
  double qpi;
  bool isIncludedInQPI;

  bool selectedInEnlistment = false;

  // default constructor
  Course(
    int id,
    String code,
    String section,
    int color,
    int days,
    int start,
    int end,
    int inEnlistment,
    String profName,
    String notes,
    int units,
    double qpi,
    bool isIncludedInQPI,
  ) {
    this.id = id;

    this.code = code;
    this.section = section;
    this.color = Color(color);

    this.days = [];
    String instr = days.toString().padLeft(6, '0');
    for (int i = 0; i < 6; i++) this.days.add(instr[i] == '1');

    this.start = start;
    this.end = end;

    this.inEnlistment = inEnlistment == 1;
    this.profName = profName;
    this.notes = notes;

    this.units = units;
    this.qpi = qpi;
    this.isIncludedInQPI = isIncludedInQPI;
  }

  // web constructor
  Course.fromData() {}

  // constructor from map
  factory Course.fromMap(Map map) {
    return Course(
      map[CentralDatabaseHelper.id],
      // map[CentralDatabaseHelper.year],
      // map[CentralDatabaseHelper.sem],
      map[CentralDatabaseHelper.code],
      map[CentralDatabaseHelper.section],
      map[CentralDatabaseHelper.color],
      map[CentralDatabaseHelper.days],
      map[CentralDatabaseHelper.start],
      map[CentralDatabaseHelper.end],
      map[CentralDatabaseHelper.inEnlistment],
      map[CentralDatabaseHelper.professor],
      map[CentralDatabaseHelper.notes],
      map[CentralDatabaseHelper.units],
      map[CentralDatabaseHelper.qpi],
      map[CentralDatabaseHelper.isIncludedInQPI],
    );
  }

  // getter for letter grade
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
