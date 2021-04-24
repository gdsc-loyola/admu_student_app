import 'package:flutter/material.dart';
import 'package:admu_student_app/screens/onboarding.dart';

class login extends StatelessWidget {
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
                padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('onboarding.png'),
                      radius: 100,
                    ),
                    Text('Welcome to Beadle!',
                        style: TextStyle(
                            color: Colors.deepPurple[300],
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                    // Google Sign in
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
                              Image(
                                image: AssetImage('google.png'),
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
                                    borderRadius: BorderRadius.circular(2),
                                    side: BorderSide(color: Colors.blue)))),
                      ),
                    ),
                    // Apple Sign in
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
                              Image(
                                image: AssetImage('apple.png'),
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
                                    borderRadius: BorderRadius.circular(2),
                                    side: BorderSide(color: Colors.black)))),
                      ),
                    ),
                    // No Account?
                    Text('No account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => onboarding()),
                          );
                        },
                        child: Text(
                          'Continue as Guest',
                          style: TextStyle(
                            color: Colors.deepPurple[300],
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                    // Continue as Guest
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
