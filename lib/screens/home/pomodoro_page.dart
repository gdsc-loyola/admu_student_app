import 'dart:async';

import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/constants/app_effects.dart';
import 'package:admu_student_app/models/user_cache.dart';
import 'package:admu_student_app/widgets/home/pomodoro_button_row.dart';
import 'package:admu_student_app/widgets/modals/help.dart';
import 'package:admu_student_app/widgets/buttons.dart';
import 'package:admu_student_app/widgets/help_button.dart';

class PomodoroPage extends StatefulWidget {
  @override
  _PomodoroPageState createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  bool shortSelected = true;
  bool pomodoroSelected = false;
  bool longSelected = false;

  String buttontitle = 'Start';
  bool isPressed = false;

  Timer _timer;
  int _start = 300;

  void startTimer(int timerDuration) {
    if (_timer != null) {
      _timer.cancel();
      // cancelVibrate();
    }
    setState(() {
      _start = timerDuration;
    });
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            print('alarm');
            // vibrate();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void pauseTimer() {
    if (_timer != null) _timer.cancel();
  }

  void unpauseTimer() => startTimer(_start);

  @override
  void initState() {
    super.initState();

    if (UserCache.pomodoro) {
      UserCache.pomodoro = false;
      UserCache.save();

      WidgetsBinding.instance.addPostFrameCallback((_) => _showHowTo());
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _showHowTo() async {
    await HelpModal.showHelp(
      context,
      title: 'Pomodoro',
      strings: [
        '1',
        '2',
        '3',
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var dur = Duration(seconds: _start);

    String _printDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
    }

    return Scaffold(
      backgroundColor: AppColors.PRIMARY_ALT,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Container for the Text Row
          Container(
            padding: EdgeInsets.fromLTRB(16, 71, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Pomodoro Technique',
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          color: AppColors.GRAY_LIGHT[2],
                        ),
                  ),
                ),
                HelpButton(isInverted: true, onTap: _showHowTo),
              ],
            ),
          ),

          // Container for the Gray Box, original height 498
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.GRAY_LIGHT[2],
                borderRadius: BorderRadius.all(Radius.circular(16)),
                boxShadow: [AppEffects.SHADOW],
              ),
              margin: EdgeInsets.fromLTRB(32, 40, 32, 72), // orig bot 130
              child: Column(
                children: [
                  // Container for the Button Row
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 48, 16, 0), // 56 -> 49 48?
                    height: 39,
                    child: PomodoroButtonRow(() {
                      setState(() {
                        shortSelected = true;
                        pomodoroSelected = false;
                        longSelected = false;
                        isPressed = false;
                        buttontitle = "Start";

                        pauseTimer();
                        _start = 300;
                      });
                    }, () {
                      setState(() {
                        shortSelected = false;
                        pomodoroSelected = true;
                        longSelected = false;
                        isPressed = false;
                        buttontitle = "Start";

                        pauseTimer();
                        _start = 1500;
                      });
                    }, () {
                      setState(() {
                        shortSelected = false;
                        pomodoroSelected = false;
                        longSelected = true;
                        isPressed = false;
                        buttontitle = "Start";

                        pauseTimer();
                        _start = 900;
                      });
                    }),
                  ),

                  // Container for Timer
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(24, 16, 24, 16), // orig 72v
                      child: FittedBox(
                        child: Text(
                          "${_printDuration(dur)}",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: AppColors.PRIMARY_MAIN,
                                fontSize: null,
                              ),
                        ),
                      ),
                    ),
                  ),

                  // Container for short buttons
                  Container(
                    padding: EdgeInsets.fromLTRB(35, 0, 35, 80),
                    child: Row(
                      children: [
                        // Start/Pause Button
                        Expanded(
                          child: CustomButton(
                            ButtonSize.short,
                            '$buttontitle',
                            AppColors.PRIMARY_MAIN,
                            AppColors.GRAY_LIGHT[2],
                            () {
                              setState(() {
                                isPressed ? isPressed = false : isPressed = true;
                                isPressed
                                    ? buttontitle = 'Pause'
                                    : buttontitle = 'Start';
                                isPressed ? unpauseTimer() : pauseTimer();
                              });
                            },
                            shadows: [AppEffects.SHADOW],
                          ),
                        ),
                        SizedBox(width: 25),

                        // Clear Button
                        Expanded(
                          child: CustomButton(
                            ButtonSize.short,
                            'Clear',
                            AppColors.PRIMARY_MAIN,
                            AppColors.PRIMARY_MAIN,
                            () {
                              setState(() {
                                pauseTimer();
                                isPressed = false;
                                buttontitle = 'Start';

                                shortSelected
                                    ? _start = 300
                                    : pomodoroSelected
                                        ? _start = 1500
                                        : longSelected
                                            ? _start = 900
                                            : _start = 0;
                              });
                            },
                            outlined: true,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
