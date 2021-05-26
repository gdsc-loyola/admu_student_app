import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_scraper/web_scraper.dart';

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
      start: DateTime.now().add(Duration(days: 1)),
      end: DateTime.now(),
    ),
    Event(
      name: 'Write INTACT journal',
      tags: 'INTACT, Acads',
      start: DateTime.now().add(Duration(days: 3)),
      end: DateTime.now(),
    ),
  ];
  List<Event> _events = [];

  get events => _events;

  List<Event> getEventsByMonth(DateTime date) {
    List<Event> filtered = [];

    for (Event e in _events) {
      if (e.start == null) continue;
      if (e.start.year == date.year && e.start.month == date.month)
        filtered.add(e);
    }

    // might be better to use database query

    filtered.sort((a, b) => a.start.day.compareTo(b.start.day));
    return filtered;
  }

  List<Event> getEventsByDay(DateTime date) {
    List<Event> filtered = [];

    for (Event e in _events) {
      if (e.start == null) continue;
      if (e.start.year == date.year &&
          e.start.month == date.month &&
          e.start.day == date.day) filtered.add(e);
    }

    // might be better to use database query

    filtered.sort((a, b) => a.start.hour.compareTo(b.start.day));
    return filtered;
  }

  CalendarEvents() {
    // sample data for testing
    if (kIsWeb) _events.addAll(_sampleData);

    _updateList();

    getAcademicCalendar();
  }

  void syncToCalendar() async {
    // syncs event to Google calendar
  }

  void getAcademicCalendar() async {
    // web scraping

    print('attempting to scrape academic calendar...');

    /*final webScraper = WebScraper('http://regcom.ateneo.edu');

    if (await webScraper.loadWebPage('/')) {
      List<Map<String, dynamic>> elements =
          webScraper.getElement('div#cards > div.card > div.flipper', []);
      print(elements);
    } else {
      print('problem scraping');
    }*/

    // var response = await http.get(
    //   Uri.http('regcom.ateneo.edu', ''),
    //   headers: {
    //     // 'User-Agent':
    //     //     'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36',
    //     'Access-Control-Request-Method': 'GET',
    //   },
    // );

    // if (response.statusCode == 200) {
    //   print(response.body);
    // } else {
    //   print('error with http GET: response code ${response.statusCode}');
    // }

    /*
  void initChaptersTitleScrap() async {
    final rawUrl =
        'https://unacademy.com/course/gravitation-for-iit-jee/D5A8YSAJ';
    final webScraper = WebScraper('https://unacademy.com');
    final endpoint = rawUrl.replaceAll(r'https://unacademy.com', '');
    if (await webScraper.loadWebPage(endpoint)) {
      final titleElements = webScraper.getElement(
          'div.Week__Wrapper-sc-1qeje5a-2 > a.Link__StyledAnchor-sc-1n9f3wx-0 '
          '> div.ItemCard__ItemInfo-xrh60s-1 '
          '> h6.H6-sc-1gn2suh-0',
          []);
      print(titleElements);
      final titleList = <String>[];
      titleElements.forEach((element) {
        final title = element['title'];
        titleList.add('$title');
      });
      print(titleList);
      if (mounted)
        setState(() {
          this.titleList = titleList;
        });
    } else {
      print('Cannot load url');
    }
  }

    <div id="cards" style="margin-top:51px;">
        <div class="grid-sizer"></div>

        <!--one-->
        <div class="card wrap" ontouchstart="this.classList.toggle('hover');">
            <!--div style="height:100%; overflow:hidden;">
                    <img class="cardimg" src="images/2.png" width="100%">
                </div-->
            <div class="flipper">
                <div class="front">
                    <!--div style="background-color: rgba(255,255,255,0.7); width: 80%; margin-left: 10%;"-->
                    <h3>January</h3>
                    <h1>25</h1>
                    <img src="images/online.png">
                    <!--/div-->
                </div>
                <div class="back">
                    <!--div style="background-color: rgba(255,255,255,0.7); width: 80%; margin-left: 10%;"-->
                    <ul>
                        <li>Online Registration for Second Semester SY 2020-2021 (Round 1): Seniors/Superseniors & New Graduate Students (Round 1)</li>
                    </ul>
                    <!--/div-->
                </div>
            </div>
        </div>

Access to XMLHttpRequest at 'http://regcom.ateneo.edu/' from origin 'http://localhost:54591' has been blocked by CORS policy: No 'Access-Control-Allow-Origin' header is present on the requested resource.
multipart_request.dart.js:714 GET http://regcom.ateneo.edu/ net::ERR_FAILED

dart_sdk.js:7024 Uncaught (in promise) Error: Instance of 'WebScraperException'
    at Object.throw_ [as throw] (dart_sdk.js:5333)
    at web_scraper.WebScraper.new.loadWebPage (web_scraper.dart.js:87)
    at loadWebPage.throw (<anonymous>)
    at dart_sdk.js:39037
    at _RootZone.runBinary (dart_sdk.js:38893)
    at _FutureListener.thenAwait.handleError (dart_sdk.js:33886)
    at handleError (dart_sdk.js:34450)
    at Function._propagateToListeners (dart_sdk.js:34476)
    at _Future.new.[_completeError] (dart_sdk.js:34322)
    at async._AsyncCallbackEntry.new.callback (dart_sdk.js:34361)
    at Object._microtaskLoop (dart_sdk.js:39175)
    at _startMicrotaskLoop (dart_sdk.js:39181)
    at dart_sdk.js:34688

  */
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
