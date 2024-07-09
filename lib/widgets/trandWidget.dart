import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/movie.dart';
import '../viewModel/homeViewModel.dart';
import 'movieBox.dart';

class TrandWidget extends StatelessWidget {

  const TrandWidget( {super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {

      Movie? movieTrend;
      movieTrend = context.watch<HomeViewModel>().movieTrend;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 4.0),
          child: Text(
            'Trending TV Shows This Week',
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
