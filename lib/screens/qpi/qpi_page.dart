import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:admu_student_app/main.dart';
import 'package:admu_student_app/models/academic_records.dart';
import 'package:admu_student_app/models/year.dart';
import 'package:admu_student_app/screens/qpi/qpi_semester.dart';
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
      padding: EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Cumulative QPI',
                  style: GoogleFonts.dmSans(
                    color: Color(0xFF474747),
                    height: 1.0,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CircleAvatar(
                // placeholder, use new widget
                backgroundColor: PrimaryColor,
                radius: 14,
              ),
            ],
          ),
          SizedBox(height: 24.0),
          QPIView(value: Provider.of<AcademicRecords>(context).cumulativeQPI),
          SizedBox(height: 48.0),
          Text(
            'QPI Overview',
            style: GoogleFonts.dmSans(
              color: Color(0xFF474747),
              height: 1.0,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: years.length,
            itemBuilder: (_, index) {
              Year yr = years[index];

              return Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => SemesterPage(sem: yr.sems[0])),
                    );
                  },
                  child: Container(
                    // placeholder for navigation, use new widget
                    color: Colors.grey[300],
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(yr.yearString),
                        ),
                        Text('${yr.yearlyQPI}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
