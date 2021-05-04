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
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PrivacyPolicyPage()),
              );
            },
            child: Text('privacy policy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ContactUsPage()),
              );
            },
            child: Text('contact us'),
          ),
        ],
      ),
    );
  }
}
