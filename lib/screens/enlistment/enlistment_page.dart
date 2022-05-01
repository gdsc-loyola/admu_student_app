import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/_all_courses.dart';
import 'package:admu_student_app/models/_course.dart';
import 'package:admu_student_app/models/user_cache.dart';
import 'package:admu_student_app/widgets/enlistment/enlistment_class.dart';
import 'package:admu_student_app/widgets/home/empty_state.dart';
import 'package:admu_student_app/widgets/modals/alert.dart';
import 'package:admu_student_app/widgets/modals/custom_snack_bar.dart';
import 'package:admu_student_app/widgets/modals/help.dart';
import 'package:admu_student_app/screens/enlistment/preview_schedule.dart';
import 'package:admu_student_app/screens/add_class.dart';
import 'package:admu_student_app/widgets/buttons.dart';
import 'package:admu_student_app/widgets/help_button.dart';

class EnlistmentPage extends StatefulWidget {
  @override
  _EnlistmentPageState createState() => _EnlistmentPageState();
}

class _EnlistmentPageState extends State<EnlistmentPage> {
  bool _isSelecting = false;

  @override
  void initState() {
    super.initState();

    if (UserCache.enlistment) {
      UserCache.enlistment = false;
      UserCache.save();

      WidgetsBinding.instance.addPostFrameCallback((_) => _showHowTo());
    }
  }

  void _showHowTo() async {
    await HelpModal.showHelp(
      context,
      title: 'Enlistment',
      strings: [
        'To add a class, tap the + button at the top right corner.',
        'Fill out the required fields and hit done after!',
        'Tap select and add the confirmed classes to your schedule.',
      ],
    );
  }

  void _onPreviewSchedule(List<Map<String, dynamic>> grouped) {
    List<Course> forSched = [];

    for (Map<String, dynamic> m in grouped) {
      for (Course s in m['subjects']) {
        if (s.selectedInEnlistment) forSched.add(s);
      }
    }

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => PreviewSchedule(forSched)));
  }

  void _onAddSchedule() async {
    bool added = false;

    // show dialog
    await AlertModal.showAlert(
      context,
      iconData: Icons.access_time_rounded,
      iconColor: AppColors.SECONDARY_MAIN,
      header: 'Add to your schedule?',
      description: null,
      acceptText: 'Confirm',
      acceptColor: AppColors.PRIMARY_MAIN,
      onAccept: () {
        Provider.of<AllCourses>(context, listen: false).addEnlistmentSchedule();
        added = true;
      },
    );

    if (added) {
      CustomSnackBar.showSnackBar(context, 'Added to schedule!');
      /*showGeneralDialog(
        context: context,
        pageBuilder: (_, __, ___) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              padding: EdgeInsets.fromLTRB(32, 32, 32, 88),
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.close_rounded),
                        iconSize: 36,
                        color: AppColors.GRAY_DARK[0],
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppColors.SUCCESS_MAIN,
                    size: 75,
                  ),
                  Text('Hooray! Added to your schedule.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: AppColors.GRAY_DARK[0])),
                ],
              ),
            ),
          );
        },
      );*/
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> groupedSubjs =
        Provider.of<AllCourses>(context).getEnlistmentSubjects();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: AppColors.GRAY_LIGHT[2],
          onPressed: () => Navigator.of(context).pop(),
          iconSize: 32,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_rounded),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AddClassPage(
                  inEnlistment: true,
                ),
              ));
            },
            iconSize: 32,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 40, 16, 32), // 32?
        child: Column(
          children: [
            // header
            Row(
              children: [
                Expanded(
                  child: Text('Enlistment Preparer',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: AppColors.GRAY_DARK[0])),
                ),
                HelpButton(onTap: _showHowTo),
              ],
            ),
            SizedBox(height: 24), // ?
            // header 2
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Classes',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: AppColors.PRIMARY_MAIN),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.PRIMARY_LIGHT.withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isSelecting = !_isSelecting;
                      });
                    },
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    child: Ink(
                      child: Container(
                        height: 24,
                        width: 72,
                        child: Center(
                          child: Text(
                            _isSelecting ? 'Cancel' : 'Select',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.PRIMARY_MAIN),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // list of subjs
            groupedSubjs.length > 0
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: groupedSubjs.length,
                    itemBuilder: (_, index) {
                      Widget card = EnlistmentClassCard(
                        color: groupedSubjs[index]['color'],
                        code: groupedSubjs[index]['code'],
                        subjects: groupedSubjs[index]['subjects'],
                        isSelecting: _isSelecting,
                      );

                      return Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: card,
                      );
                    },
                  )
                : EmptyState(
                    topText: 'No Class Input Yet',
                    bottomText:
                        'Add your desired classes for enlistment by tapping the + button at the top right corner!'),
            SizedBox(height: 48),

            // create schedule
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // preview sched
                CustomButton(
                  ButtonSize.short,
                  'Preview Schedule',
                  AppColors.SECONDARY_MAIN,
                  AppColors.SECONDARY_MAIN,
                  () => _onPreviewSchedule(groupedSubjs),
                  outlined: true,
                ),
                SizedBox(width: 16),

                // add to sched
                CustomButton(
                  ButtonSize.short,
                  'Add to Schedule',
                  AppColors.SECONDARY_MAIN,
                  AppColors.GRAY_LIGHT[2],
                  _onAddSchedule,
                  shadows: [AppEffects.SHADOW],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
