import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/widgets/circular_check_mark.dart';

class SmallEventCard extends StatefulWidget {
  final String text;
  final DateTime start;

  SmallEventCard({this.text = '', this.start});

  @override
  _SmallEventCardState createState() => _SmallEventCardState();
}

class _SmallEventCardState extends State<SmallEventCard> {
  bool _isDone = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
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
              padding: EdgeInsets.only(right: 12.0),
            ),
            Expanded(
              child: Text(
                widget.text,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: AppColors.GRAY,
                    decoration: _isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ),
            Text(
              widget.start == null
                  ? ''
                  : (widget.start.hour.toString().padLeft(2, '0') +
                      ':' +
                      widget.start.minute.toString().padLeft(2, '0')),
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: AppColors.GRAY_DARK[2]),
            ),
          ],
        ),
      ),
    );
  }
}
