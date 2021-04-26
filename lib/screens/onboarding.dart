import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:admu_student_app/screens/main.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

List<PageViewModel> listPagesViewModel = [
  PageViewModel(
    title: "Hi, I'm Beadle!",
    body:
        "Your accessible companion for all your productivity and organization needs.",
    image: Container(
      color: Colors.deepPurple[300],
    ),
    decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        bodyTextStyle: TextStyle(fontSize: 15),
        imageFlex: 2),
  ),
  PageViewModel(
    title: "Feature 1",
    body:
        "description of feature description of feature description of feature.",
    image: Container(
      color: Colors.yellow,
    ),
    decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        bodyTextStyle: TextStyle(fontSize: 15),
        imageFlex: 2),
  ),
  PageViewModel(
    title: "Feature 2",
    body:
        "description of feature description of feature description of feature.",
    image: Container(
      color: Colors.red,
    ),
    decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        bodyTextStyle: TextStyle(fontSize: 15),
        imageFlex: 2),
  ),
  PageViewModel(
    title: "Feature 3",
    body:
        "description of feature description of feature description of feature.",
    image: Container(
      color: Colors.blue,
    ),
    decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        bodyTextStyle: TextStyle(fontSize: 15),
        imageFlex: 2),
  ),
  PageViewModel(
    title: "Feature 4",
    body:
        "description of feature description of feature description of feature.",
    image: Container(
      color: Colors.green,
    ),
    decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        bodyTextStyle: TextStyle(fontSize: 15),
        imageFlex: 2),
  )
];

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(),
      child: Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            body: Container(
              child: IntroductionScreen(
                pages: listPagesViewModel,
                onDone: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => MyHomePage()),
                  );
                },
                showDoneButton: true,
                showSkipButton: true,
                showNextButton: true,
                next: Icon(Icons.arrow_forward),
                nextColor: Colors.blue,
                skip: Text('Skip'),
                skipColor: Colors.grey[600],
                done:
                    Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
