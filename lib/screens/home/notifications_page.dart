import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/notification_center.dart';
import 'package:admu_student_app/models/notification.dart';
import 'package:admu_student_app/widgets/home/notification_card.dart';

class NotificationsPage extends StatelessWidget {
  Future<bool> _onBack(BuildContext context) async {
    Provider.of<NotificationCenter>(context, listen: false).setReadAll();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    List<Notif> notifs = Provider.of<NotificationCenter>(context).notifs;

    Scaffold scaffold = Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            _onBack(context);

            Navigator.of(context).pop();
          },
          iconSize: 32,
        ),
        title: Text(
          'Reminders',
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: AppColors.GRAY_LIGHT[2]),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 24, 16, 32),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: notifs.length,
          itemBuilder: (_, index) => Padding(
            padding: EdgeInsets.only(top: 16),
            child: NotificationCard(notifs[index]),
          ),
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () => _onBack(context),
      child: scaffold,
    );
  }
}
