import 'package:flutter/material.dart';

import 'package:admu_student_app/models/notification.dart';

class NotificationCenter extends ChangeNotifier {
  List<Notif> _notifs = [
    Notif(
      0,
      'Welcome, Atenean!',
      'Hi from Beadle! I\'m so glad to have you here. Hope you enjoy!',
      'Hello',
      DateTime.now(),
      false,
    ),
    Notif(
      2,
      '',
      'You missed this...',
      'Testing 1',
      DateTime.now().subtract(Duration(minutes: 25)),
      false,
    ),
    Notif(
      1,
      'Enlistment is near!',
      '',
      'Enlistment!',
      DateTime.now().subtract(Duration(hours: 5)),
      true,
    ),
    Notif(
      0,
      'Welcome, Atenean!',
      'Hi from Beadle! I\'m so glad to have you here. Hope you enjoy!',
      '',
      DateTime.now().subtract(Duration(days: 25)),
      true,
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
}
