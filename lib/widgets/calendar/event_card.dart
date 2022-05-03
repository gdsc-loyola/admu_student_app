import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/screens/add_task.dart';
import 'package:admu_student_app/widgets/calendar/event_tag.dart';
import 'package:admu_student_app/widgets/circular_check_mark.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onMark;

  EventCard({@required this.event, this.onMark});

  @override
  Widget build(BuildContext context) {
    final TextStyle _timeStyle = Theme.of(context)
        .textTheme
        .caption
        .copyWith(color: AppColors.GRAY_DARK[2]);

    String timeText = '';

    if (event.start != null && event.end == null)
      timeText = 'Starts\n${event.getReadableStartTime()}';
    else if (event.start == null && event.end != null)
      timeText = 'Ends\n${event.getReadableEndTime()}';
    else if (event.start != null && event.end != null)
      timeText =
          '${event.getReadableStartTime()}\nto\n ${event.getReadableEndTime()}';

    Widget card = Container(
      height: 120, // original 123
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [AppEffects.SHADOW_FOR_WHITE],
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      foregroundDecoration: event.isDone
          ? BoxDecoration(
              color: AppColors.GRAY_LIGHT[2],
              backgroundBlendMode: BlendMode.softLight)
          : null,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // check mark
            Padding(
              child: CircularCheckMark(
                isDone: event.isDone,
                onTap: () {
                  Provider.of<CalendarEvents>(context, listen: false)
                      .setEventDone(event, !event.isDone);

                  if (onMark != null) onMark();
                },
              ),
              padding: EdgeInsets.only(right: 20.0),
            ),

            // column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // title
                  Text(
                    event.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        fontWeight: FontWeight.w500,
                        color: event.isDone
                            ? AppColors.GRAY_DARK[2]
                            : AppColors.GRAY,
                        decoration: event.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 2.0),
                  ),
                  // agenda
                  event.agenda.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            event.agenda,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: AppColors.GRAY_DARK[2]),
                          ),
                        )
                      : Container(),

                  // tags
                  (event.tags == null || event.tags.isEmpty)
                      ? Container()
                      : EventTag(event.tags),
                ],
              ),
            ),

            // time
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                timeText,
                style: _timeStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => AddTaskPage(
            event: event,
            isEditing: true,
          ),
        ));
      },
      child: card,
    );
  }
}
