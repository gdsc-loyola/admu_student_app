import 'package:admu_student_app/models/class_schedule.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/screens/main_app.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;
  PageController _controller = PageController();
  bool isLast = false;

  List<Widget> _pages = [
    SliderPage(
      title: "Hi I'm Beadle",
      description:
          "Your accessible companion for all your productivity and organization needs.",
    ),
    SliderPage(
      title: "QPI",
      description:
          "Keep track of your grades throughout your entire stay in ADMU. Beadle will take care of all the computations for you!",
    ),
    SliderPage(
      title: "Calendar",
      description:
          "Organize all your tasks, meetings, or events in one place. Need to sync with Google Calendar? Beadle’s got your back!",
    ),
    SliderPage(
      title: "Class Schedule",
      description:
          "Easily create a timetable of your classes. You’ll never miss a class again!",
    ),
    SliderPage(
      title: "Enlistment",
      description:
          "Prepare for enlistment season by listing down your class options from different time slots or professors! ",
    ),
    SliderPage(
      title: "LS Address Book",
      description:
          "View the complete list of offices in ADMU and their respective emails for you to contact! ",
    ),
    SliderPage(
      title: "Ready to Explore?",
      description:
          "Just tap “Let’s go” whenever you’re ready! We’re excited for you.",
    ),
  ];

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onchanged,
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Skip / Go Back Button
                  InkWell(
                    onTap: () {
                      (_currentPage == _pages.length - 1)
                          ? _controller.previousPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOutQuint)
                          : _controller.jumpToPage(6);
                    },
                    child: AnimatedContainer(
                      alignment: Alignment.center,
                      duration: Duration(milliseconds: 100),
                      height: (_currentPage == (_pages.length - 1)) ? 64 : 48,
                      width: (_currentPage == (_pages.length - 1)) ? 128 : 80,
                      decoration: BoxDecoration(
                        color: (_currentPage == _pages.length - 1)
                            ? AppColors.GRAY_LIGHT[0]
                            : Colors.transparent,
                        borderRadius: (_currentPage == _pages.length - 1)
                            ? BorderRadius.circular(8)
                            : BorderRadius.circular(35),
                      ),
                      child: (_currentPage == (_pages.length - 1))
                          ? Text(
                              "Go Back",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: AppColors.GRAY_DARK[1]),
                            )
                          : Text(
                              'Skip',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: AppColors.GRAY_DARK[1]),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 23,
                  ),
                  // Dot Indicator
                  (_currentPage == _pages.length - 1)
                      ? SizedBox()
                      : Row(
                          children: List<Widget>.generate(
                            _pages.length,
                            (int index) {
                              return AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: 10,
                                width: (index == _currentPage) ? 30 : 10,
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: (index == _currentPage)
                                      ? AppColors.SECONDARY_MAIN
                                      : AppColors.GRAY_LIGHT[0],
                                ),
                              );
                            },
                          ),
                        ),
                  SizedBox(
                    width: 41,
                  ),
                  // Next Button
                  InkWell(
                    onTap: () {
                      (_currentPage == _pages.length - 1)
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainPage(),
                              ),
                            )
                          : _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOutQuint);
                    },
                    child: AnimatedContainer(
                      alignment: Alignment.center,
                      duration: Duration(milliseconds: 100),
                      height: (_currentPage == (_pages.length - 1)) ? 64 : 48,
                      width: (_currentPage == (_pages.length - 1)) ? 128 : 48,
                      decoration: BoxDecoration(
                        color: AppColors.PRIMARY_MAIN,
                        borderRadius: (_currentPage == _pages.length - 1)
                            ? BorderRadius.circular(8)
                            : BorderRadius.circular(35),
                      ),
                      child: (_currentPage == (_pages.length - 1))
                          ? Text("Let's Go!",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: AppColors.GRAY_LIGHT[2]))
                          : Icon(
                              Icons.navigate_next,
                              size: 50,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SliderPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  SliderPage({this.title, this.description, this.image});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
              color: Colors.red,
              height: MediaQuery.of(context).size.height / 2),
          SizedBox(
            height: 48,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            description,
            style: TextStyle(
              height: 1.5,
              fontWeight: FontWeight.normal,
              fontSize: 14,
              letterSpacing: 0.7,
            ),
            textAlign: TextAlign.center,
          ),
          Spacer()
        ],
      ),
    );
  }
}
