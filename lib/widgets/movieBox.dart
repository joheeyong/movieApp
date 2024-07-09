import 'package:flutter/material.dart';
import '../model/movie.dart';

class MovieBox extends StatelessWidget {
  final Results? results;

  const MovieBox(this.results, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: const EdgeInsets.all(8),
            child: Image.network(
              "http://image.tmdb.org/t/p//w154/${results?.posterPath.toString()}",
            ));
  }
}
