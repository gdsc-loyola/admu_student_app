import 'dart:convert' show jsonDecode;

import 'package:flutter/services.dart';

class LSDirectory {
  static List<dynamic> _data = [];

  static void load() async {
    String rawJson = await rootBundle.loadString('assets/text/directory.json');

    _data = jsonDecode(rawJson);
  }

  static List<Map<String, dynamic>> getFiltered(
    String keyword, [
    bool isSearching = false,
  ]) {
    List<Map<String, dynamic>> maps = [];

    for (Map cluster in _data) {
      List<Map<String, dynamic>> added = [];

      for (Map office in cluster['offices']) {
        if (!isSearching) {
          added.add(office);
          continue;
        }

        // check name
        if (office['name'].toLowerCase().contains(keyword.toLowerCase())) {
          maps.add(office);
          continue;
        }

        // check emails
        for (String email in office['emails']) {
          if (email.toLowerCase().contains(keyword.toLowerCase())) {
            maps.add(office);
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
