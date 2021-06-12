import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/class_schedule.dart';
import 'package:admu_student_app/models/user_cache.dart';
import 'package:admu_student_app/widgets/modals/help.dart';
import 'package:admu_student_app/widgets/schedule/schedule_timetable.dart';
import 'package:admu_student_app/widgets/help_button.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  void initState() {
    super.initState();

    if (UserCache.schedule) {
      UserCache.schedule = false;
      UserCache.save();

      WidgetsBinding.instance.addPostFrameCallback((_) => _showHowTo());
    }
  }

  void _showHowTo() async {
    await HelpModal.showHelp(
      context,
      title: 'Class Schedule',
      strings: [
        'To add your classes, tap the + button at the top right corner.',
        'You can edit your classes by clicking on it.',
        'Delete your schedule by clicking on the trash icon.',
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> latestSched =
        Provider.of<ClassSchedule>(context).getLatestScheduleDetails();

    return Container(
      padding: EdgeInsets.fromLTRB(16, 40, 16, 32),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Class Schedule',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: AppColors.GRAY_DARK[0]),
                ),
              ),
              HelpButton(onTap: _showHowTo),
            ],
          ),
          SizedBox(height: 24),
          Expanded(child: ScheduleTimetable(latestSched)),
        ],
      ),
    );
  }
}
