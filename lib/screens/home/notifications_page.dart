import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              Text(
                'Reminders',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: AppColors.GRAY_LIGHT[2]),
              ),
              SizedBox(
                height: 24,
                width: 24,
              )
            ],
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 23, 16, 0),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
