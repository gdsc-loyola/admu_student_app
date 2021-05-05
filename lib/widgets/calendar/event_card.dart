import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/widgets/circular_check_mark.dart';

class EventCard extends StatefulWidget {
  final String text;
  final String agenda;
  final String tags;
  final DateTime start;
  final DateTime end;

  EventCard(
      {this.text = '', this.agenda = '', this.tags, this.start, this.end});

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _isDone = false;

  @override
  Widget build(BuildContext context) {
    final TextStyle _timeStyle = Theme.of(context)
        .textTheme
        .caption
        .copyWith(color: AppColors.GRAY_DARK[2]);

    return Container(
      height: 120, // original 123
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [AppEffects.DEFAULT_SHADOW],
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.GRAY,
                      decoration: _isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationThickness: 2.0),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    widget.agenda,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: AppColors.GRAY_DARK[2]),
                  ),
                ),
                (widget.tags == null || widget.tags.isEmpty)
                    ? SizedBox(height: 24)
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        height: 24,
                        decoration: BoxDecoration(
                          color: AppColors.SECONDARY_LIGHT.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        child: Center(
                          child: Text(
                            widget.tags,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.SECONDARY_MAIN),
                          ),
                        ),
                      ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: (widget.start == null || widget.end == null)
                  ? []
                  : [
                      Text(
                        (widget.start.hour.toString().padLeft(2, '0') +
                            ':' +
                            widget.start.minute.toString().padLeft(2, '0') +
                            (widget.start.hour < 12 ? ' AM' : ' PM')),
                        style: _timeStyle,
                      ),
                      Text('to', style: _timeStyle),
                      Text(
                        (widget.end.hour.toString().padLeft(2, '0') +
                            ':' +
                            widget.end.minute.toString().padLeft(2, '0') +
                            (widget.end.hour < 12 ? ' AM' : ' PM')),
                        style: _timeStyle,
                      ),
                    ],
            ),
          ],
        ),
      ),
    );
  }
}
