import 'package:flutter/material.dart';

import 'package:admu_student_app/models/central_database.dart';

class Event {
  int id;
  String name;
  String agenda;
  String tags;
  DateTime start;
  DateTime end;
  bool isDone;
  bool inAcademicCalendar;

  Event({
    this.id,
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
      id: map[CentralDatabaseHelper.id],
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

  String getReadableTime() {
    if (start != null && end != null) {
      if (start.year == end.year &&
          start.month == end.month &&
          start.day == end.day)
        return '${getReadableStartTime()}\nto\n${getReadableEndTime()}';
      else
        return 'Starts\n${start.month}/${start.day} ${getReadableStartTime()}\n\nEnds\n${end.month}/${end.day} ${getReadableEndTime()}';
    } else if (start == null && end != null)
      return 'Ends\n${getReadableEndTime()}';
    else if (start != null && end != null)
      return 'Starts\n${getReadableStartTime()}';
    else
      return '';
  }

  String getReadableStartTime() =>
      (start.hour < 12 ? (start.hour == 0 ? 12 : start.hour) : start.hour - 12)
          .toString()
          .padLeft(2, '0') +
      ':' +
      start.minute.toString().padLeft(2, '0') +
      (start.hour < 12 ? ' AM' : ' PM');

  String getReadableEndTime() =>
      (end.hour < 12 ? (end.hour == 0 ? 12 : end.hour) : end.hour - 12)
          .toString()
          .padLeft(2, '0') +
      ':' +
      end.minute.toString().padLeft(2, '0') +
      (end.hour < 12 ? ' AM' : ' PM');

  int compareTo(Event other) {
    DateTime a, b;

    if (start != null)
      a = start;
    else if (end != null) a = end;

    if (other.start != null)
      b = other.start;
    else if (other.end != null) b = other.end;

    if (a == null) return -1;
    if (b == null) return 1;

    return a.compareTo(b);
  }
}
