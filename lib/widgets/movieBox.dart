// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../model/movie.dart';
import '../util/var.dart';
import 'NetflixBottomSheet.dart';

class MovieBox extends StatelessWidget {
  final Results? results;

  const MovieBox(this.results, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        child: GestureDetector(
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
                        movie: results!, type: results!.type.toString());
                  });
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: [
                    shimmer,
                    results?.posterPath != null
                        ? Image.network(
                            "http://image.tmdb.org/t/p//w154/${results?.posterPath.toString()}",
                            width: 140,
                            height: 220,
                            fit: BoxFit.fitHeight)
                        : Container()
                  ],
                ))));
  }
}
