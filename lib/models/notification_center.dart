import 'package:admu_student_app/models/event.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/models/notification.dart';

class NotificationCenter extends ChangeNotifier {
  List<Notif> _notifs = [
    Notif(
      1,
      'Welcome, Atenean!',
      'Hi from Beadle! I\'m so glad to have you here. Hope you enjoy!',
      '',
      DateTime.now(),
      false,
    ),
  ];

  NotificationCenter() {
    load();
  }

  void save() async {
    // save to file
  }

  void load() async {
    // load from file

    notifyListeners();
  }

  static String getReadableDate(Notif notif) {
    Duration diff = DateTime.now().difference(notif.date);

    if (diff < Duration(minutes: 1))
      return 'Now';
    else if (diff < Duration(hours: 1))
      return '${diff.inMinutes}m';
    else if (diff < Duration(days: 1))
      return '${diff.inHours}h';
    else
      return '${notif.date.month.toString().padLeft(2, '0')}/${notif.date.day.toString().padLeft(2, '0')}/${notif.date.year}';
  }

  List<Notif> get notifs => _notifs;

  int getNumUnread() {
    int count = 0;
    for (Notif n in _notifs) {
      if (!n.isRead) count++;
    }

    return count;
  }

  void addNotification(Notif notif) {
    _notifs.add(notif);

    save();

    notifyListeners();
  }

  void addEnlistmentNotification() {
    addNotification(Notif(
      1,
      '',
      'Enlistment is coming! You may use our enlistment preparer in the side menu to get ready.',
      '',
      DateTime.now(),
      false,
    ));
  }

  void addUnfinishedNotification(Event e) {
    addNotification(Notif(
      2,
      '',
      'Oh no, you missed this task. You got this, buddy!',
      e.name,
      DateTime.now(),
      false,
    ));
  }

  void setReadAll() {
    for (Notif n in _notifs) n.isRead = true;
    save();

    notifyListeners();
  }
}
