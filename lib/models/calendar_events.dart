import 'package:flutter/material.dart';

import 'package:admu_student_app/models/event.dart';

class CalendarEvents extends ChangeNotifier {
  List<Event> events = [];

  void syncToCalendar() async {
    // syncs event to Google calendar
  }

  void addEvent(String title, DateTime startDate, DateTime endDate,
      String label, String notes, bool isTask) async {
    // add to database
    // key ID
    // sync to cal
    events.add(Event(title, startDate, endDate, label, notes, isTask));

    _updateList();
  }

  void editEvent(int id, String title, DateTime startDate, DateTime endDate,
      String label, String notes, bool isTask) async {
    // edit from database
    // key ID
    // sync to cal

    _updateList();
  }

  void deleteEvent(int id) async {
    // delete from database
    // key ID

    _updateList();
  }

  void _updateList() async {
    // query from database: table of events

    notifyListeners();
  }
}
