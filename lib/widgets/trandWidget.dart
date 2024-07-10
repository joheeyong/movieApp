import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/movie.dart';
import '../viewModel/homeViewModel.dart';
import 'movieBox.dart';

// ignore: must_be_immutable
class TrandWidget extends StatelessWidget {
  String type;

  TrandWidget(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {


      Movie? movieTrend;
      String title="";

     switch(type) {
        case "allWeek":
          movieTrend = context.watch<HomeViewModel>().movieAllWeek;
          title = "최근 가장 인기많은 작품";
          break;
        case "movieDay":
          movieTrend = context.watch<HomeViewModel>().movieMovieDay;
          title = "오늘의 인기 영화 PICK!";
          break;
       case "movieWeek":
         movieTrend = context.watch<HomeViewModel>().movieMovieWeek;
         title = "이번주 핫한 영화예요";
       case "TVDay":
         movieTrend = context.watch<HomeViewModel>().movieTVDay;
         title = "TV 영화추천";
       default:
         print("none");
     }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 4.0),
          child: Text(title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
            height: 230,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movieTrend?.results != null ? movieTrend?.results.length : 0,
                itemBuilder: (context, index) {
                  return MovieBox(movieTrend?.results[index]);
                }))
      ],)
      ;
    },);
  }
}
