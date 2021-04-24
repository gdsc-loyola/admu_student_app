import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:admu_student_app/screens/main.dart';

class onboarding extends StatefulWidget {
  @override
  _onboardingState createState() => _onboardingState();
}

List<PageViewModel> listPagesViewModel = [
  PageViewModel(
    title: "Hi, I'm Beadle!",
    body:
        "Your accessible companion for all your productivity and organization needs.",
    image: const Center(
      child:
          Image(image: AssetImage('assets/onboarding.png'), fit: BoxFit.fill),
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
    image: const Center(
      child:
          Image(image: AssetImage('assets/onboarding.png'), fit: BoxFit.fill),
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
    image: const Center(
      child:
          Image(image: AssetImage('assets/onboarding.png'), fit: BoxFit.fill),
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
    image: const Center(
      child:
          Image(image: AssetImage('assets/onboarding.png'), fit: BoxFit.fill),
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
    image: const Center(
      child:
          Image(image: AssetImage('assets/onboarding.png'), fit: BoxFit.fill),
    ),
    decoration: const PageDecoration(
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        bodyTextStyle: TextStyle(fontSize: 15),
        imageFlex: 2),
  )
];

class _onboardingState extends State<onboarding> {
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
