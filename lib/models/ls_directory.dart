import 'dart:convert' show jsonDecode;

import 'package:flutter/services.dart';

class LSDirectory {
  static List<dynamic> _data = [];

  static void load() async {
    String rawJson = await rootBundle.loadString('assets/text/directory.json');

    _data = jsonDecode(rawJson);
  }

  static List<Map<String, dynamic>> getFiltered(String keyword) {
    // if (keyword.isEmpty) return (List<Map<String, dynamic>>) _data;

    List<Map<String, dynamic>> maps = [];

    for (Map cluster in _data) {
      List<Map<String, dynamic>> added = [];

      for (Map office in cluster['offices']) {
        if (keyword.isEmpty) {
          added.add(office);
          continue;
        }

        // check name
        if (office['name'].contains(keyword)) {
          added.add(office);
          continue;
        }

        // check emails
        for (String email in office['emails']) {
          if (email.contains(keyword)) {
            added.add(office);
            continue;
          }
        }
      }

      if (added.length > 0)
        maps.add({
          'title': cluster['title'],
          'offices': added,
        });
    }

    return maps;
  }
}
