import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/notification_center.dart';
import 'package:admu_student_app/models/notification.dart';

class NotificationCard extends StatelessWidget {
  final Notif notif;

  NotificationCard(this.notif);

  Widget _buildContent(BuildContext context) {
    List<Widget> widgets = [];

    if (notif.title.isNotEmpty) {
      widgets.add(Text(notif.title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.GRAY_DARK[0],
              )));
    }

    if (notif.message.isNotEmpty) {
      if (widgets.isNotEmpty) widgets.add(SizedBox(height: 4));

      widgets.add(Text(notif.message,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: AppColors.GRAY_DARK[0])));
    }

    if (notif.calloutMessage.isNotEmpty) {
      if (widgets.isNotEmpty) widgets.add(SizedBox(height: 4));

      widgets.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // line
          Container(
            decoration: BoxDecoration(
              color: AppColors.SECONDARY_MAIN,
              borderRadius: BorderRadius.all(Radius.circular(8)), // ?
            ),
            height: 10, // ?
            width: 4, // ?
          ),
          SizedBox(width: 10),

          // text
          Expanded(
            child: Text(notif.calloutMessage,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: AppColors.GRAY_DARK[0])), // ?
          ),
        ],
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: notif.isRead ? AppColors.GRAY_LIGHT[2] : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      height: 135,
      child: Stack(
        children: [
          // unread indicator
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.SECONDARY_MAIN,
                shape: BoxShape.circle,
              ),
              height: 12,
              width: 12,
            ),
          ),

          // time
          Positioned(
            bottom: 8,
            right: 14,
            child: Text(
              NotificationCenter.getReadableDate(notif),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: AppColors.GRAY_DARK[2],
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.right,
            ),
          ),

          // fill
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 24,
              ), // temporary?
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // icon
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    width: 55, // unknown?
                    height: 55,
                  ),
                  SizedBox(width: 16),

                  // content
                  Expanded(child: _buildContent(context)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
