// ignore_for_file: unrelated_type_equality_checks, prefer_is_empty

import 'package:examproject1/widgets/DownLoad/recentItemVIewDatabaseHelper.dart';
import 'package:flutter/material.dart';
import '../../model/movie.dart';

class DownLoadScreen extends StatefulWidget {
  const DownLoadScreen({super.key});

  @override
  State<DownLoadScreen> createState() => DownLoadScreenState();
}

class DownLoadScreenState extends State<DownLoadScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> onRefresh() async {
    return Future<void>.value();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.white,
        child: Center(
            child: Container(
          width: MediaQuery.of(context).size.width >= 768
              ? 768
              : MediaQuery.of(context).size.width,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: RefreshIndicator(
                color: const Color.fromRGBO(153, 153, 153, 1),
                edgeOffset: 45,
                displacement: 100,
                onRefresh: onRefresh,
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    children: [
                      Container(
                        color: Colors.white,
                        child: FutureBuilder<List<Results>>(
                          future: instance.getProducts(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Results>> snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data!.length != 0) {
                              return Container(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length > 100
                                      ? 100
                                      : snapshot.data!.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                15, 15, 15, 0),
                                            child: Text(snapshot
                                                .data![index].overview
                                                .toString())),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          width: double.infinity,
                                          height: 1,
                                          color: Colors.black12,
                                        )
                                      ],
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Container(
                                  margin: const EdgeInsets.only(top: 60),
                                  child: const Center(
                                    child: Text(
                                      "최근 본 상품이 없습니다.",
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          height: 1.2,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'Helvetica',
                                          color:
                                              Color.fromRGBO(102, 102, 102, 1)),
                                    ),
                                  ));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )),
          ),
        )));
  }
}
