import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/screens/add_task.dart';
import 'package:admu_student_app/widgets/calendar/event_tag.dart';
import 'package:admu_student_app/widgets/modals/delete.dart';
import 'package:admu_student_app/widgets/circular_check_mark.dart';

// used for the monthly view in the calendar
class CompactEventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onMark;

  CompactEventCard({@required this.event, this.onMark});

  String _getTimeString() {
    if (event.start != null && event.end == null)
      return event.getReadableStartTime();
    else if (event.start == null && event.end != null)
      return 'Ends ${event.getReadableEndTime()}';
    else
      return '${event.getReadableStartTime()} to ${event.getReadableEndTime()}';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => AddTaskPage(
            event: event,
            isEditing: true,
          ),
        ));
      },
      onLongPress: () {
        DeleteModal.showAlert(context, () {
          Provider.of<CalendarEvents>(context, listen: false)
              .deleteEvent(event);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.GRAY_LIGHT[2],
          boxShadow: [AppEffects.SHADOW_FOR_WHITE],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // check mark
            CircularCheckMark(
              isDone: event.isDone,
              onTap: () {
                Provider.of<CalendarEvents>(context, listen: false)
                    .setEventDone(event, !event.isDone);

                if (onMark != null) onMark();
              },
            ),
            SizedBox(width: 16),

            // text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // event name
                  Text(
                    event.name,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: event.isDone
                              ? AppColors.GRAY_TRANSPARENT50
                              : AppColors.GRAY,
                          // decoration: event.isDone
                          //     ? TextDecoration.lineThrough
                          //     : TextDecoration.none,
                          // decorationThickness: 2.0,
                        ),
                  ),
                  event.agenda.isNotEmpty ? SizedBox(height: 4) : Container(),

                  // agenda
                  event.agenda.isNotEmpty
                      ? Text(
                          event.agenda,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: AppColors.GRAY_DARK[1],
                              ),
                        )
                      : Container(),
                  SizedBox(height: 8),

                  // details
                  Row(
                    children: [
                      // time
                      Text(
                        _getTimeString(),
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: event.isDone
                                  ? AppColors.PRIMARY_MAIN_TRANSPARENT50
                                  : AppColors.PRIMARY_MAIN,
                            ),
                      ),
                      SizedBox(width: 8),

                      // tag
                      (event.tags == null || event.tags.isEmpty)
                          ? Container()
                          : EventTag(event.tags),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
