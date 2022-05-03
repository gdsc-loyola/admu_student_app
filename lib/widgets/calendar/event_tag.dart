import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';

class EventTag extends StatelessWidget {
  final String tag;

  EventTag(this.tag);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.SECONDARY_LIGHT.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Center(
              child: Text(
                tag,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.SECONDARY_MAIN),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
