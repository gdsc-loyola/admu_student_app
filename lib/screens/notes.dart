import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';

class NotesPage extends StatelessWidget {
  final bool isEditing;

  NotesPage({this.isEditing = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.PRIMARY_MAIN,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Text('CLASS NAME'),
            Spacer(),
            IconButton(icon: Icon(Icons.more_vert_rounded), onPressed: () {})
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 36, 16, 0),
        child: Column(
          children: [
            // Row for Text and Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notes',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: AppColors.GRAY_DARK[0]),
                ),
                Spacer(),
                Container(
                    width: 72,
                    height: 24,
                    decoration: BoxDecoration(
                        color: AppColors.PRIMARY_ALT.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child: Ink(
                        child: Center(
                          child: Text(
                            'Select',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    fontSize: 14,
                                    color: AppColors.PRIMARY_MAIN),
                          ),
                        ),
                      ),
                    )),
                IconButton(icon: Icon(Icons.add), onPressed: () {})
              ],
            )
          ],
        ),
      ),
    );
  }
}
