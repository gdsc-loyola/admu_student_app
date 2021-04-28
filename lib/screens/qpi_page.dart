import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/models/academic_records.dart';
import 'package:admu_student_app/models/year.dart';
import 'package:admu_student_app/screens/qpi/semester.dart';
import 'package:admu_student_app/widgets/qpi/qpi_view.dart';

class QPIPage extends StatefulWidget {
  @override
  _QPIPageState createState() => _QPIPageState();
}

class _QPIPageState extends State<QPIPage> {
  @override
  Widget build(BuildContext context) {
    List<Year> years = Provider.of<AcademicRecords>(context).years;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Cumulative QPI'),
          QPIView(Provider.of<AcademicRecords>(context).cumulativeQPI),
          Text('QPI Overview'),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: years.length,
            itemBuilder: (_, index) {
              Year yr = years[index];
              // return year dropdown
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => SemesterPage(sem: yr.sems[0])),
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Text(yr.yearString),
                    ),
                    Text('${yr.yearlyQPI}'),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
