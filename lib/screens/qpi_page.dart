import 'package:flutter/material.dart';

import 'package:admu_student_app/widgets/buttons.dart';
import 'package:admu_student_app/main.dart';

class QPIPage extends StatefulWidget {
  @override
  _QPIPageState createState() => _QPIPageState();
}

class _QPIPageState extends State<QPIPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: PrimaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LongButton(
                  'Stateless Long Button', Colors.grey[200], Colors.black, () {
                print("stateless long button");
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 384,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SquareButton("M", Colors.white, Colors.black, () {
                          print('Pressed M');
                        }),
                        SquareButton("T", Colors.white, Colors.black, () {
                          print('Pressed T');
                        }),
                        SquareButton("W", Colors.white, Colors.black, () {
                          print('Pressed W');
                        }),
                        SquareButton("Th", Colors.white, Colors.black, () {
                          print('Pressed Th');
                        }),
                        SquareButton("F", Colors.white, Colors.black, () {
                          print('Pressed F');
                        }),
                        SquareButton("S", Colors.white, Colors.black, () {
                          print('Pressed S');
                        }),
                      ],
                    ),
                  )
                ],
              ),
              DropDown()
            ],
          ),
        ),
      ),
    );
  }
}
