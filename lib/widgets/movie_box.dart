import 'package:flutter/material.dart';
import '../model/movie.dart';

class MovieBox extends StatelessWidget {
  final Results? results;

  const MovieBox(this.results);

  @override
  Widget build(BuildContext context) {
    print("http://image.tmdb.org/t/p//w154/${results!.posterPath.toString()}");
    return
      Container(
        width: 110,
        height: 220,
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(50),),
        padding: EdgeInsets.all(8),
              child: Image.network(
                  "http://image.tmdb.org/t/p//w154/${results!.posterPath.toString()}",));
  }
}
