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
      true,
    ),
    Notif(
      2,
      '',
      'You missed this...',
      'Testing 1',
      DateTime.now().subtract(Duration(minutes: 25)),
      true,
    ),
    Notif(
      1,
      'Enlistment is near!',
      '',
      '',
      DateTime.now().subtract(Duration(hours: 5)),
      false,
    ),
    Notif(
      0,
      'Welcome, Atenean!',
      'Hi from Beadle! I\'m so glad to have you here. Hope you enjoy!',
      '',
      DateTime.now().subtract(Duration(days: 25)),
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
    Duration diff = notif.date.difference(DateTime.now());

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

  void addNotification(Notif notif) {
    _notifs.add(notif);

    save();

    notifyListeners();
  }
}
