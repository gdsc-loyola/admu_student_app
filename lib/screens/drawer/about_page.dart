import 'package:admu_student_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:admu_student_app/screens/drawer/contact_us_page.dart';
import 'package:admu_student_app/screens/drawer/privacy_policy_page.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => AboutPage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.white,
        ),
      ),


      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 363,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Who's Beadle?",
                    style: Theme.of(context).textTheme.headline4.copyWith(color: AppColors.GRAY_DARK[0]),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset('onboarding.png',
                  height: 112,
                  width: 112,
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text("Beadle is your accessible companion for all \nyour productivity and organization needs."
                      "\nWhether it’s your tasks, your grades, or your \nclasses, Beadle’s here for you!",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.GRAY_DARK[0]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          //CURRENT VERSION
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(vertical: 15),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Icon(Icons.info_outline_rounded)
                ),
                Expanded(
                  flex: 3,
                  child: Text('Current Version',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.GRAY_DARK[0]),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text('v0.01',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.GRAY_DARK[0]),
                  ),
                ),
              ],
            ),
          ),

          //PRIVACY POLICY
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PrivacyPolicyPage()),
              );
            },
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: Icon(Icons.info_outline_rounded)
                  ),
                  Expanded(
                    flex: 3,
                    child: Text('Privacy Policy',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.GRAY_DARK[0]),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.arrow_forward_ios_rounded,
                      color: AppColors.PRIMARY_MAIN,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //CONTACT US
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ContactUsPage()),
              );
            },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey),
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Icon(Icons.mail_outline_rounded)
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('Contact Us',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.GRAY_DARK[0]),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.arrow_forward_ios_rounded,
                        color: AppColors.PRIMARY_MAIN,
                      ),
                    ),
                  ],
                ),
              ),
          ),

        ],
      ),
    );
  }
}
