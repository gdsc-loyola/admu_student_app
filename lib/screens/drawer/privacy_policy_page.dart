import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:admu_student_app/constants/app_colors.dart';
import 'package:admu_student_app/widgets/custom_drop_down.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  Map<String, dynamic> _data;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    String jsonText =
        await rootBundle.loadString('assets/text/privacy_policy.json');

    setState(() {
      _data = json.decode(jsonText);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_data == null) _loadData();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          color: AppColors.GRAY_LIGHT[2],
          icon: Icon(Icons.chevron_left_rounded),
          iconSize: 36,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _data == null
          ? Container()
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(24, 48, 24, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _data['title'],
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: AppColors.GRAY),
                  ),
                  SizedBox(height: 16),
                  Text(_data['info'],
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: AppColors.GRAY_DARK[0])),
                  SizedBox(height: 16),
                  Text(_data['text'],
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: AppColors.GRAY)),
                  SizedBox(height: 24),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _data['categories'].length,
                    itemBuilder: (_, index) {
                      var categ = _data['categories'][index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 14),
                        child: CustomDropDown(
                          childrenPadding: EdgeInsets.fromLTRB(24, 0, 24, 48),
                          title: Text(
                            categ['heading'],
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.GRAY_DARK[0],
                                    ),
                          ),
                          children: [
                            Text(
                              categ['text'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: AppColors.GRAY_DARK[0]),
                            ),
                            categ['subcategories'] == null
                                ? Container()
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: categ['subcategories'].length,
                                    itemBuilder: (_, index2) {
                                      var subcateg =
                                          categ['subcategories'][index2];

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: Text(subcateg['subheading'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .GRAY_DARK[1])),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 16),
                                            child: Text(subcateg['text'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(
                                                        color: AppColors
                                                            .GRAY_DARK[0])),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 56), // original 54
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo/dsc.png', width: 36, height: 36),
                      SizedBox(width: 6),
                      Text(
                        'Developer Student Clubs Loyola',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: AppColors.GRAY_DARK[2]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
