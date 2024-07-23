// ignore_for_file: empty_catches

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../model/movie.dart';
import '../../../viewModel/homeViewModel.dart';
import '../../util/var.dart';
import '../NetflixBottomSheet.dart';
import '../movieBox.dart';

class MoreLikeComponent extends StatefulWidget {


  const MoreLikeComponent({super.key});

  @override
  State<MoreLikeComponent> createState() => MoreLikeComponentState();
}

class MoreLikeComponentState extends State<MoreLikeComponent> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  Movie? movieTVDay;

  @override
  Widget build(BuildContext context) {
    movieTVDay = context.read<HomeViewModel>().movieTVDay;
    super.build(context);
    return          GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: movieTVDay?.results.length,
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
        mainAxisSpacing: 10, //수평 Padding
        crossAxisSpacing: 10, //수직 Padding
        childAspectRatio: 1 /1.5
      ),
      itemBuilder: (BuildContext context,int index){
        // return Text(index.toString());
        return  GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  backgroundColor: const Color(0xff2b2b2b),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                  ),
                  builder: (context) {
                    return NetflixBottomSheet(
                        movie: movieTVDay!.results[index], type: movieTVDay!.results[index].type.toString());
                  });
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: [
                    Shimmer(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Colors.grey[900]!,
                              Colors.grey[900]!,
                              Colors.grey[800]!,
                              Colors.grey[900]!,
                              Colors.grey[900]!
                            ],
                            stops: const <double>[
                              0.0,
                              0.35,
                              0.5,
                              0.65,
                              1.0
                            ]),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            border: Border(),
                          ),
                        )),
                    Image.network(
                        "http://image.tmdb.org/t/p//w154/${movieTVDay!.results[index].posterPath.toString()}",
                        width: 140,
                        height: 220,
                        fit: BoxFit.fitHeight)
                  ],
                )));
      },
    );
  }
}
