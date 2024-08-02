// ignore_for_file: unrelated_type_equality_checks, prefer_is_empty

import 'package:examproject1/widgets/DownLoad/recentItemVIewDatabaseHelper.dart';
import 'package:flutter/material.dart';
import '../../model/movie.dart';
import '../NewAndHot/NewAndHotTile.dart';

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
    return  Scaffold(
      body: RefreshIndicator(
          color: const Color.fromRGBO(153, 153, 153, 1),
          edgeOffset: 45,
          displacement: 100,
          onRefresh: onRefresh,
          child: ListView(
            children: [
              FutureBuilder<List<Results>>(
                future: instance.getProducts(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Results>> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!.length != 0) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length > 100
                          ? 100
                          : snapshot.data!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder:
                          (BuildContext context, int index) {
                        return NewAndHotTile(
                            movie: snapshot.data![index],
                            type: snapshot.data![index].type.toString());
                      },
                    );
                  } else {
                    return Container(
                        margin: const EdgeInsets.only(top: 60),
                        child: const Center(
                          child: Text(
                            "저장된 영상이 없습니다.",
                            style: TextStyle(
                                height: 1.2,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Helvetica',
                                color:Colors.white,
                          ),
                        )));
                  }
                },
              )
            ],
          )),
    );
  }
}
