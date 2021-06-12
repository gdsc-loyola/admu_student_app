import 'package:admu_student_app/widgets/home/empty_state.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/widgets/home/event_card_preview.dart';
import 'package:admu_student_app/widgets/home/pomodoro.dart';

class HomePage extends StatefulWidget {
  final String today = DateFormat.yMMMMEEEEd('en_US').format(DateTime.now());

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<Event> events =
        Provider.of<CalendarEvents>(context).getEventsByDay(DateTime.now());

    return Container(
      padding: EdgeInsets.fromLTRB(16, 40, 16, 40),
      child: Column(
        children: [
          // icon and name
          Row(
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
                  events.length > 0
                      ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: events.length,
                      itemBuilder: (_, index) =>
                          HomeEventCard(event: events[index]),
                    ),
                  )
                      : EmptyState()
                ],
              ),
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
