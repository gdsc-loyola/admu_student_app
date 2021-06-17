import 'package:admu_student_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:admu_student_app/constants/app_effects.dart';


class ContactUsPage extends StatefulWidget {

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {

    @override
    Future<void> goToFacebook() async {
      String fbProtocolUrl;
      String fallBackUrl = 'https://www.facebook.com/dscloyola/';
      if(Platform.isIOS){
        fbProtocolUrl = 'fb://profile/101293334597789';
      } else{
        fbProtocolUrl = 'fb"//page/101293334597789';
      }

      try{
        bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

        if(!launched){
          await launch(fbProtocolUrl, forceSafariVC: false);
        }
      }
      catch(e){
        await launch(fallBackUrl, forceSafariVC: false);
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          color: AppColors.GRAY_LIGHT[2],
          icon: Icon(Icons.arrow_back_ios_rounded),
          iconSize: 32,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 17, top: 40),
            child: Text("Contact Us",
              style: Theme.of(context).textTheme.headline4.copyWith(color: AppColors.GRAY_DARK[0]),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [AppEffects.SHADOW_FOR_WHITE],
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [

                  ///FACEBOOK
                  Padding(
                    padding: EdgeInsets.only(bottom: 19.0),
                    child: Row(
                      children: [
                        //Orange Rectangle Thingy
                        Container(
                          width: 5,
                          height: 72,
                          decoration: BoxDecoration(
                            color: AppColors.SECONDARY_MAIN,
                          ),
                        ),
                        //Text & Link
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 14.0),
                                    child: Image.asset(
                                      'assets/logo/facebook.png',
                                      height: 26,
                                      width: 26,
                                      isAntiAlias: true,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                  Text(
                                    'Facebook',
                                      style: Theme.of(context).textTheme
                                      .headline6
                                      .copyWith(color: AppColors.GRAY_DARK[0],),
                                  ),
                                ],
                              ),
                              InkWell(
                                child: Text(
                                  'https://www.facebook.com/dscloyola/',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                          color: AppColors.GRAY_DARK[0],
                                          decoration: TextDecoration.underline),
                                ),
                                onTap: () => goToFacebook(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///LinkedIn
                  Padding(
                    padding: EdgeInsets.only(bottom: 19.0),
                    child: Row(
                      children: [
                        //Orange Rectangle Thingy
                        Container(
                          width: 5,
                          height: 72,
                          decoration: BoxDecoration(
                            color: AppColors.SECONDARY_MAIN,
                          ),
                        ),
                        //Text & Link
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 14.0),
                                    child: Image.asset(
                                      'assets/logo/linkedin.png',
                                      height: 26,
                                      width: 26,
                                      isAntiAlias: true,
                                    ),
                                  ),
                                  Text(
                                    'LinkedIn',
                                    style: Theme.of(context).textTheme
                                        .headline6
                                        .copyWith(color: AppColors.GRAY_DARK[0],),
                                  ),
                                ],
                              ),
                              InkWell(
                                child: Text(
                                  'https://www.linkedin.com/company/\ndsc-ateneo/mycompany/',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                          color: AppColors.GRAY_DARK[0],
                                          decoration: TextDecoration.underline),
                                ),
                                onTap: () => launch('https://www.linkedin.com/company/dsc-ateneo/mycompany/'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ///Email
                  Row(
                    children: [
                      //Orange Rectangle Thingy
                      Container(
                        width: 5,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.SECONDARY_MAIN,
                        ),
                      ),
                      //Text & Link
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 14.0),
                                  child: Icon(Icons.email_outlined),
                                ),
                                Text(
                                  'Email',
                                  style: Theme.of(context).textTheme
                                      .headline6
                                      .copyWith(color: AppColors.GRAY_DARK[0],),
                                ),
                              ],
                            ),
                            Text(
                              'dsc.ateneo@gmail.com',
                              style: Theme.of(context).textTheme
                                  .caption
                                  .copyWith(color: AppColors.GRAY_DARK[0]),
                            ),
                          ],
                        ),
                      ),
                    ],
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
