import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:admu_student_app/models/event.dart';

class CalendarEvents extends ChangeNotifier {
  final List<Event> _sampleData = [
    Event(
      name: 'Write HISTO paper',
      agenda: 'Search for references',
      tags: 'HISTO 11',
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 1)),
    ),
    Event(
      name: 'Submit PE video',
      agenda: 'Record first',
      tags: 'Acads',
    ),
    Event(
      name: 'Meeting with team',
      agenda: 'Dev and design sprints',
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 1, minutes: 30)),
    ),
    Event(
      name: 'Share secret code',
      agenda: 'Code code code',
    ),
    Event(
      name: 'Write INTACT journal',
      tags: 'INTACT, Acads',
    ),
  ];
  List<Event> _events = [];

  get events => _events;

  CalendarEvents() {
    // sample data for testing
    if (kIsWeb) _events.addAll(_sampleData);

    _updateList();
  }

  void syncToCalendar() async {
    // syncs event to Google calendar
  }

  void getAcademicCalendar() async {
    // web scraping
  }

  void addEvent(String title, String label, String notes, DateTime start,
      DateTime end, bool isDone) async {
    // add to database
    // key ID
    // sync to cal
    // events.add(Event(title, startDate, endDate, label, notes, isTask));

    _updateList();
  }

  void editEvent(int id, String title, String label, String notes,
      DateTime start, DateTime end, bool isDone) async {
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
    if (kIsWeb) {
      notifyListeners();
      return;
    }

    notifyListeners();
  }
}
