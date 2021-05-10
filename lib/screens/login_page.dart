import 'package:flutter/material.dart';

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
                      backgroundImage: AssetImage('onboarding.png'),
                      radius: 100,
                    ),
                    Text(
                      'Welcome to Beadle!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.deepPurple[300],
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
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
                                      'google.png',
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
                                      'apple.png',
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
                          Text('No account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => OnboardingPage()),
                              );
                            },
                            child: Text(
                              'Continue as Guest',
                              style: TextStyle(
                                  color: Colors.deepPurple[300],
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          )
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
