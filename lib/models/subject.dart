import 'dart:math';

import 'package:flutter/material.dart';

import 'package:admu_student_app/models/central_database.dart';

class Subject {
  String code;
  int yearNum;
  int semNum;
  int qtrNum;
  Color color;
  List<bool> days;
  int start;
  int end;

  Subject(String code, int yearNum, int semNum, int qtrNum, int color, int days,
      int start, int end) {
    this.code = code;
    this.yearNum = yearNum;
    this.semNum = semNum;
    this.qtrNum = qtrNum;
    this.color = Color(color);

    this.days = [];
    String instr = days.toString().padLeft(6, '0');
    for (int i = 0; i < 6; i++) this.days.add(instr[i] == '1');

    this.start = start;
    this.end = end;
  }

  factory Subject.fromMap(Map map) {
    return Subject(
      map[CentralDatabaseHelper.code],
      map[CentralDatabaseHelper.year],
      map[CentralDatabaseHelper.sem],
      map[CentralDatabaseHelper.quarter],
      map[CentralDatabaseHelper.color],
      map[CentralDatabaseHelper.days],
      map[CentralDatabaseHelper.start],
      map[CentralDatabaseHelper.end],
    );
  }
}
