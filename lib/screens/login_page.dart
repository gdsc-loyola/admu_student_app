import 'package:flutter/material.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/models/user_cache.dart';
import 'package:admu_student_app/screens/main_app.dart';
import 'package:admu_student_app/screens/onboarding_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(),
      child: Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            body: Center(
              child: Container(
                //Parent Column
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/onboarding.png'),
                      radius: 100,
                    ),
                    Text(
                      'Welcome to Beadle!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: Colors.black),
                    ),
                    // Container for Buttons
                    Container(
                      height: 136,
                      width: 264,
                      // Column for Buttons
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 264,
                            height: 56,
                            color: Colors.transparent,
                            child: TextButton(
                              onPressed: () {},
                              child: Container(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/logo/google.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 40),
                                      child: Text(
                                        'Sign In with Google',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          BeveledRectangleBorder>(
                                      BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          side:
                                              BorderSide(color: Colors.blue)))),
                            ),
                          ),
                          Container(
                            width: 264,
                            height: 56,
                            color: Colors.transparent,
                            child: TextButton(
                              onPressed: () {},
                              child: Container(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/logo/apple.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 40),
                                      child: Text(
                                        'Sign In with Apple',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          BeveledRectangleBorder>(
                                      BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          side: BorderSide(
                                              color: Colors.black)))),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Container for Bottom Text
                    Container(
                      width: 144,
                      height: 52,
                      // Column for Bottom Text
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'No account?',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: AppColors.GRAY_DARK[2]),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => UserCache.onboarding
                                        ? OnboardingPage()
                                        : MainPage()),
                              );
                            },
                            child: Text(
                              'Continue as Guest',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: AppColors.PRIMARY_MAIN,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
