import 'dart:convert';
import 'dart:io';

import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/models/notification_center.dart';

class UserCache {
  // true = first time: open popup or page
  // false: don't open popup or page
  static bool onboarding = true;
  static bool login = false;

  static bool pomodoro = true;

  static bool calendar = true;
  static bool schedule = true;
  static bool qpi = true;

  static bool enlistment = true;
  static bool lsDirectory = true;

  static List<int> pomodoroTimers = [60 * 5, 60 * 25, 60 * 15];

  static int _enlistmentMonth = -1;

  static void load(BuildContext context) async {
    if (kIsWeb) return;

    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path;
    File file = File('$path/user_cache.json');

    String rawJson = await file.readAsString();

    Map<String, dynamic> map = jsonDecode(rawJson);

    onboarding = map['onboarding'];
    login = map['login'];
    pomodoro = map['pomodoro'];
    calendar = map['calendar'];
    schedule = map['schedule'];
    qpi = map['qpi'];
    enlistment = map['enlistment'];
    lsDirectory = map['lsDirectory'];

    pomodoroTimers = map['pomodoroTimers'].cast<int>();

    _enlistmentMonth = map['enlistmentMonth'];

    DateTime now = DateTime.now();
    List<int> eMonths = [1, 6, 8];

    for (int i = 0; i < eMonths.length; i++) {
      if (now.month == eMonths[i] && now.month != _enlistmentMonth) {
        Provider.of<NotificationCenter>(context, listen: false)
            .addEnlistmentNotification();
        break;
      }
    }

    // check tasks
    List<Event> events =
        Provider.of<CalendarEvents>(context, listen: false).events;

    for (Event e in events) {
      if (e.isDone) continue;
      if (!e.notified && e.end.isBefore(DateTime.now()))
        Provider.of<NotificationCenter>(context, listen: false)
            .addUnfinishedNotification(e);
    }
  }

  static void save() async {
    if (kIsWeb) return;

    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path;
    File file = File('$path/user_cache.json');

    file.writeAsString(jsonEncode({
      'onboarding': onboarding,
      'login': login,
      'pomodoro': pomodoro,
      'calendar': calendar,
      'schedule': schedule,
      'qpi': qpi,
      'enlistment': enlistment,
      'lsDirectory': lsDirectory,
      'pomodoroTimers': pomodoroTimers,
    }));
  }
}
