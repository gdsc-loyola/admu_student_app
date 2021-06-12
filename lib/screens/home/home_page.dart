import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/widgets/calendar/event_card_small.dart';
import 'package:admu_student_app/widgets/home/empty_state.dart';
import 'package:admu_student_app/widgets/home/pomodoro.dart';

class HomePage extends StatefulWidget {
  final String today = DateFormat.yMMMMEEEEd('en_US').format(DateTime.now());
  int tasks;

  HomePage({Key key, this.tasks = 1}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<Event> _events =
    Provider.of<CalendarEvents>(context, listen: false).events;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: new BoxDecoration(
                    color: AppColors.PRIMARY_LIGHT,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hey, Lorem!',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.left,
                  ),

                  Text(
                    'Ready to start your day?',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.GRAY_DARK[1]),
                  ),
                ],
              )
            ],
          ),
        ),

        Text(widget.today,
        style: Theme.of(context).textTheme.headline5,
        ),

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
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(16, 26, 16, 0),
          child: Pomodoro(),
        ),
      ],
    );
  }
}
