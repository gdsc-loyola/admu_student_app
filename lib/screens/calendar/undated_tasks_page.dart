import 'package:admu_student_app/screens/enlistment/enlistment_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/widgets/calendar/event_card.dart';
import 'package:admu_student_app/widgets/home/empty_state.dart';

class UndatedTasksPage extends StatefulWidget {
  final DateTime date;
  final Function(DateTime) onDateChange;

  UndatedTasksPage({this.date, this.onDateChange});

  @override
  _UndatedTasksPageState createState() => _UndatedTasksPageState();
}

class _UndatedTasksPageState extends State<UndatedTasksPage> {

  @override
  Widget build(BuildContext context) {
    List<Event> events =
    Provider.of<CalendarEvents>(context).getUndatedEvents();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: AppColors.GRAY_LIGHT[2],
          onPressed: () => Navigator.of(context).pop(),
          iconSize: 32,
        ),
        title: Center(
          child: Text(
            'Undated Tasks',
            style:
              Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: AppColors.GRAY_LIGHT[2]),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_rounded),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => EnlistmentPage(),
              ));
            },
            iconSize: 32,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
        child: Column(
          children: [
            // events
            events.length > 0
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
                  child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: events.length,
                  itemBuilder: (_, index){
                    return Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      child: EventCard(event: events[index]),
                    );
                  }
                  )
                )
                : EmptyState(
                topText: 'No Events Yet',
                bottomText:
                'Rest up buddy! You may add events for today using the calendar page.'
            ),
          ],
        ),
      ),
    );
  }
}
