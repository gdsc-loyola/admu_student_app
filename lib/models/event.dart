import 'package:flutter/material.dart';

import 'package:admu_student_app/models/central_database.dart';

class Event {
  String name;
  String agenda;
  String tags;
  DateTime start;
  DateTime end;
  bool isDone;
  bool inAcademicCalendar;

  Event({
    @required this.name,
    this.agenda = '',
    this.tags = '',
    this.start,
    this.end,
    this.isDone = false,
    this.inAcademicCalendar = false,
  });

  factory Event.fromMap(Map map) {
    return Event(
      name: map[CentralDatabaseHelper.name],
      agenda: map[CentralDatabaseHelper.agenda],
      tags: map[CentralDatabaseHelper.tags],
      start: map[CentralDatabaseHelper.start].isNotEmpty
          ? DateTime.parse(map[CentralDatabaseHelper.start])
          : null,
      end: map[CentralDatabaseHelper.start].isNotEmpty
          ? DateTime.parse(map[CentralDatabaseHelper.end])
          : null,
      isDone: map[CentralDatabaseHelper.isDone] == 1,
      inAcademicCalendar: map[CentralDatabaseHelper.inAcademicCalendar] == 1,
    );
  }

  String getReadableStartTime() =>
      (start.hour < 12 ? start.hour : start.hour - 12)
          .toString()
          .padLeft(2, '0') +
      ':' +
      start.minute.toString().padLeft(2, '0') +
      (start.hour < 12 ? ' AM' : ' PM');

  String getReadableEndTime() =>
      (end.hour < 12 ? end.hour : end.hour - 12).toString().padLeft(2, '0') +
      ':' +
      end.minute.toString().padLeft(2, '0') +
      (end.hour < 12 ? ' AM' : ' PM');
}
