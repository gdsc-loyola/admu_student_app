import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/screens/add_task.dart';
import 'package:admu_student_app/widgets/circular_check_mark.dart';

class SmallEventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onMark;

  SmallEventCard({@required this.event, this.onMark});

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [AppEffects.SHADOW_FOR_WHITE],
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              child: CircularCheckMark(
                isDone: event.isDone,
                onTap: () {
                  Provider.of<CalendarEvents>(context, listen: false)
                      .setEventDone(event, !event.isDone);

                  if (onMark != null) onMark();
                },
              ),
              padding: EdgeInsets.only(right: 12.0),
            ),
            Expanded(
              child: Text(
                event.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color:
                        event.isDone ? AppColors.GRAY_DARK[2] : AppColors.GRAY,
                    decoration: event.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationThickness: 2.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                '${event.start == null ? '' : event.getReadableStartTime()}${event.start != null && event.end != null ? ' to\n' : ''}${event.end == null ? '' : event.getReadableEndTime()}',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: AppColors.GRAY_DARK[2]),
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
