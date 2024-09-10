// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'oss_licenses.dart';

//  flutter_oss_licenses: (사용하는 패키지가 변경될때, https://pub.dev/packages/flutter_oss_licenses 해당 문서 절차로 oss_licenses.dart 변경

class LicencesPageActivity extends StatelessWidget {
  const LicencesPageActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
            backgroundColor: Colors.white,
            leading: null,
            titleSpacing: 0,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            foregroundColor: Colors.black,
            title: const Text(
              '오픈소스 라이선스',
              textScaleFactor: 1.0,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontFamily: 'Helvetica'),
            ),
            centerTitle: true,
            elevation: 0.35,
            flexibleSpace: SafeArea(
              child: Container(
                  color: Colors.white,
                  child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 60,
                                width: 54,
                                child: Image.asset(
                                  'asset/arrowBack.png',
                                ),
                              )),
                        ],
                      ))),
            )
          // centerTitle: true,
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: allDependencies.length,
        itemBuilder: (_, index) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => LicenceDetailPage(
                          title: allDependencies[index].name[0].toUpperCase() + allDependencies[index].name.substring(1),
                          licence: allDependencies[index].license!,
                        ),
                      ),
                    );
                  },
                  //capitalize the first letter of the string
                  child: Container(
                      height: 40,
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 15),
                      color: Colors.white,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            allDependencies[index].name[0].toUpperCase() + allDependencies[index].name.substring(1),
                            textScaleFactor: 1.0,
                            style: const TextStyle(fontFamily: 'Helvetica', fontWeight: FontWeight.w500),
                          ))),
                  // subtitle: Text(ossLicenses[index].description),
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: const Color.fromRGBO(102, 102, 102, 0.1),
              )
            ],
          );
        },
      ),
    );
  }
}

//detail page for the licence
class LicenceDetailPage extends StatelessWidget {
  final String title;
  final String licence;

  const LicenceDetailPage({required this.title, required this.licence, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
            leading: null,
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: Text(
              title,
              textScaleFactor: 1.0,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontFamily: 'Helvetica'),
            ),
            centerTitle: true,
            elevation: 0.35,
            flexibleSpace: SafeArea(
              child: Container(
                  color: Colors.white,
                  child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 60,
                                width: 54,
                                child: Image.asset(
                                  'asset/arrowBack.png',
                                ),
                              )),
                        ],
                      ))),
            )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  licence,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

