import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/screens/add_task.dart';
import 'package:admu_student_app/widgets/circular_check_mark.dart';

class SmallEventCard extends StatefulWidget {
  final Event event;

  SmallEventCard({@required this.event});

  @override
  _SmallEventCardState createState() => _SmallEventCardState();
}

class _SmallEventCardState extends State<SmallEventCard> {
  bool _isDone = false;

  @override
  void initState() {
    super.initState();

    _isDone = widget.event.isDone;
  }

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
                  isDone: _isDone,
                  onTap: () {
                    setState(() {
                      _isDone = !_isDone;
                    });
                  }),
              padding: EdgeInsets.only(right: 12.0),
            ),
            Expanded(
              child: Text(
                widget.event.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: AppColors.GRAY,
                    decoration: _isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationThickness: 2.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                widget.event.start == null
                    ? ''
                    : widget.event.getReadableStartTime(),
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
            event: widget.event,
            isEditing: true,
          ),
        ));
      },
      child: card,
    );
  }
}
