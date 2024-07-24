import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../model/movie.dart';
import '../viewModel/homeViewModel.dart';

class DiscoverWidget extends StatelessWidget {
  const DiscoverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print("DiscoverWidget.dart");

    return Builder(builder: (context) {
      Movie? movieCover;
      movieCover = context.watch<HomeViewModel>().movieDiscover;
      return Stack(
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
                width: double.infinity,
                height: MediaQuery.of(context).size.width +
                    (MediaQuery.of(context).size.width * .43),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  border: Border(),
                ),
              )),
          Container(
              height: MediaQuery.of(context).size.width +
                  (MediaQuery.of(context).size.width * .43),
              foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: const Alignment(0.0, 0.2),
                      colors: [
                    Colors.black,
                    Colors.black.withOpacity(.92),
                    Colors.black.withOpacity(.8),
                    Colors.transparent
                  ])),
              child: movieCover?.results[0].posterPath != null
                  ? Image.network(
                      "http://image.tmdb.org/t/p//original/${movieCover?.results[0].posterPath}",
                    )
                  : Container()),
        ],
      );
    });
  }
}
