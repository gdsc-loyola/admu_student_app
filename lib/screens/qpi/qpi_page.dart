import 'package:admu_student_app/widgets/modals/help.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/academic_records.dart';
import 'package:admu_student_app/models/user_cache.dart';
import 'package:admu_student_app/models/year.dart';
import 'package:admu_student_app/widgets/qpi/qpi_view.dart';
import 'package:admu_student_app/widgets/qpi/year_drop_down.dart';
import 'package:admu_student_app/widgets/help_button.dart';

class QPIPage extends StatefulWidget {
  @override
  _QPIPageState createState() => _QPIPageState();
}

class _QPIPageState extends State<QPIPage> {
  @override
  void initState() {
    super.initState();

    if (UserCache.qpi) {
      UserCache.qpi = false;
      UserCache.save();

      WidgetsBinding.instance.addPostFrameCallback((_) => _showHowTo());
    }
  }

  void _showHowTo() async {
    await HelpModal.showHelp(
      context,
      title: 'QPI Calculator',
      strings: [
        'To add your classes, tap the + button at the top right corner',
        'You can edit your classes by clicking on it.',
        'Delete your schedule by clicking on the trash icon.',
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Year> years = Provider.of<AcademicRecords>(context).years;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Cumulative QPI',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: AppColors.GRAY_DARK[0]),
                ),
              ),
              HelpButton(onTap: _showHowTo),
            ],
          ),
          SizedBox(height: 24.0),
          QPIView(value: Provider.of<AcademicRecords>(context).cumulativeQPI),
          SizedBox(height: 48.0),
          Text(
            'QPI Overview',
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: AppColors.GRAY_DARK[0]),
          ),
          SizedBox(height: 16.0),
          years.length > 0
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: years.length,
                  itemBuilder: (_, index) {
                    Year year = years[index];

                    return Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      child: YearDropDown(yearNum: year.yearNum),
                    );
                  },
                )
              : Container(), // replace with empty state

          // compsat
          Text(
            'Inspired by:',
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: AppColors.GRAY_DARK[1]),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                'assets/logo/compsat.png',
                height: 36,
                width: 36,
              ),
              Expanded(
                child: Text(
                  "Computer Society of the Ateneo's QPI Calculator",
                  softWrap: true,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: AppColors.GRAY_DARK[1]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
