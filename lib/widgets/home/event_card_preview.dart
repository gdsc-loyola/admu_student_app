import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/calendar_events.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/screens/add_task.dart';
import 'package:admu_student_app/widgets/circular_check_mark.dart';

class HomeEventCard extends StatelessWidget {
  final Event event;

  HomeEventCard({@required this.event});

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      height: 65, // including border
      padding: EdgeInsets.symmetric(horizontal: 16), // original is 18/24, 9?
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1.0,
          ),
        ),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              child: CircularCheckMark(
                isDone: event.isDone,
                onTap: () => Provider.of<CalendarEvents>(context, listen: false)
                    .setEventDone(event, !event.isDone),
              ),
              padding: EdgeInsets.only(right: 12.0), // original 13
            ),
            Expanded(
              child: Text(
                event.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Color(0xFF111111),
                    decoration: event.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationThickness: 2.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                event.start == null ? '' : event.getReadableStartTime(),
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: AppColors.GRAY_DARK[1]),
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
