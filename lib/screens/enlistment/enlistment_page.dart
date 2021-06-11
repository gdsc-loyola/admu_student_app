import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/class_schedule.dart';
import 'package:admu_student_app/models/subject.dart';
import 'package:admu_student_app/models/user_cache.dart';
import 'package:admu_student_app/widgets/enlistment/enlistment_class.dart';
import 'package:admu_student_app/widgets/modals/help.dart';
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
        '1',
        '2',
        '3',
      ],
    );
  }

  void _onSelect(Subject s) {
    print(s.code);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> groupedSubjs =
        Provider.of<ClassSchedule>(context).getEnlistmentSubjects();

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
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: groupedSubjs.length,
              itemBuilder: (_, index) {
                Widget card = EnlistmentClassCard(
                  code: groupedSubjs[index]['code'],
                  subjects: groupedSubjs[index]['subjects'],
                  isSelecting: _isSelecting,
                  onSelect: (i) =>
                      _onSelect(groupedSubjs[index]['subjects'][i]),
                );

                return Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: card,
                );
              },
            ),
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
                  () {},
                  outlined: true,
                ),
                SizedBox(width: 16),

                // add to sched
                CustomButton(
                  ButtonSize.short,
                  'Add to Schedule',
                  AppColors.SECONDARY_MAIN,
                  AppColors.GRAY_LIGHT[2],
                  () {},
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
