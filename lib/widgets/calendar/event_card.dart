import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/widgets/circular_check_mark.dart';

class EventCard extends StatefulWidget {
  final Event event;

  EventCard({@required this.event});

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _isDone = false;

  @override
  void initState() {
    super.initState();

    _isDone = widget.event.isDone;
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle _timeStyle = Theme.of(context)
        .textTheme
        .caption
        .copyWith(color: AppColors.GRAY_DARK[2]);

    Widget card = Container(
      height: 120, // original 123
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
              padding: EdgeInsets.only(right: 20.0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // title
                  Text(
                    widget.event.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.GRAY,
                        decoration: _isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 2.0),
                  ),
                  // agenda
                  widget.event.agenda.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            widget.event.agenda,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: AppColors.GRAY_DARK[2]),
                          ),
                        )
                      : Container(),
                  // tags
                  (widget.event.tags == null || widget.event.tags.isEmpty)
                      ? Container()
                      : Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 24.0),
                              height: 24,
                              decoration: BoxDecoration(
                                color:
                                    AppColors.SECONDARY_LIGHT.withOpacity(0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                              child: Center(
                                child: Text(
                                  widget.event.tags,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.SECONDARY_MAIN),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    (widget.event.start == null || widget.event.end == null)
                        ? []
                        : [
                            Text(
                              widget.event.getReadableStartTime(),
                              style: _timeStyle,
                            ),
                            Text('to', style: _timeStyle),
                            Text(
                              widget.event.getReadableEndTime(),
                              style: _timeStyle,
                            ),
                          ],
              ),
            ),
          ],
        ),
      ),
    );

    return InkWell(
      onTap: () {
        print('on tap');
      },
      child: card,
    );
  }
}
