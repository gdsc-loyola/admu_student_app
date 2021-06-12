import 'package:intl/intl.dart';
<<<<<<< HEAD

=======
>>>>>>> develop
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
<<<<<<< HEAD
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/widgets/calendar/event_card_small.dart';
import 'package:admu_student_app/widgets/home/empty_state.dart';
=======
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/widgets/home/event_card_preview.dart';
>>>>>>> develop
import 'package:admu_student_app/widgets/home/pomodoro.dart';

class HomePage extends StatefulWidget {
  final String today = DateFormat.yMMMMEEEEd('en_US').format(DateTime.now());
<<<<<<< HEAD
  int tasks;

  HomePage({Key key, this.tasks = 1}) : super(key: key);
=======

>>>>>>> develop
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    List<Event> _events =
    Provider.of<CalendarEvents>(context, listen: false).events;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
=======
    List<Event> events =
        Provider.of<CalendarEvents>(context).getEventsByDay(DateTime.now());

    return Container(
      padding: EdgeInsets.fromLTRB(16, 40, 16, 40),
      child: Column(
        children: [
          // icon and name
          Row(
>>>>>>> develop
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // icon
              Container(
                width: 80.0,
                height: 80.0,
                decoration: new BoxDecoration(
                  color: AppColors.PRIMARY_LIGHT,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 15), // 15?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name
                  Text(
                    'Hey, Lorem!',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: AppColors.GRAY_DARK[0],
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.left,
                  ),

                  // text
                  Text(
                    'Ready to start your day?',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: AppColors.GRAY_DARK[1],
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 16),

          // date
          Text(
            widget.today,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: AppColors.GRAY_DARK[0],
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(height: 16),

<<<<<<< HEAD
        //TASKS FOR TODAY
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: PhysicalModel(
            color: Colors.black,
            elevation: 8,
            child: Container(
              height: MediaQuery.of(context).size.height/2.9,
              width: MediaQuery.of(context).size.width-32,
              color: Colors.white,

              child: widget.tasks > 0
                ? SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'For Today: ' + widget.tasks.toString(),
                        style: Theme.of(context).textTheme.headline6.copyWith(color: AppColors.PRIMARY_MAIN),
                      )
=======
          // tasks
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [AppEffects.SHADOW_FOR_WHITE],
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // text
                  Text(
                    'For today: ${events.length}',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: AppColors.PRIMARY_MAIN),
                  ),
                  SizedBox(height: 16),

                  // events
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: events.length,
                      itemBuilder: (_, index) =>
                          HomeEventCard(event: events[index]),
>>>>>>> develop
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _events.length,
                      itemBuilder: (_, index) {
                        return Container(
                          child: SmallEventCard(event: _events[index]),
                        );
                      },
                    ),
                  ],
              ),
                )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'For Today: ' + widget.tasks.toString(),
                      style: Theme.of(context).textTheme.headline6.copyWith(color: AppColors.PRIMARY_MAIN),
                    )
                ),
                EmptyState(),
              ],
            )
            ),
          ),
          SizedBox(height: 32),

          // pomodoro button
          Pomodoro(),
        ],
      ),
    );
  }
}
