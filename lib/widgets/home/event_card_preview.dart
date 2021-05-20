import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/event.dart';
import 'package:admu_student_app/widgets/circular_check_mark.dart';

class HomeEventCard extends StatefulWidget {
  final Event event;

  HomeEventCard({@required this.event});

  @override
  _HomeEventCardState createState() => _HomeEventCardState();
}

class _HomeEventCardState extends State<HomeEventCard> {
  bool _isDone = false;

  @override
  void initState() {
    super.initState();

    _isDone = widget.event.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  isDone: _isDone,
                  onTap: () {
                    setState(() {
                      _isDone = !_isDone;
                    });
                  }),
              padding: EdgeInsets.only(right: 12.0), // original 13
            ),
            Expanded(
              child: Text(
                widget.event.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Color(0xFF111111),
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
                    .copyWith(color: AppColors.GRAY_DARK[1]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
