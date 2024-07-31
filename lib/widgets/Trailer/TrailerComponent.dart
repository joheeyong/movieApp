// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../model/movie.dart';
import '../../../viewModel/homeViewModel.dart';

class TrailerComponent extends StatefulWidget {
  const TrailerComponent({super.key});

  @override
  State<TrailerComponent> createState() => TrailerComponentState();
}

class TrailerComponentState extends State<TrailerComponent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Movie? movieMovieDay;

  @override
  Widget build(BuildContext context) {
    movieMovieDay = context.read<HomeViewModel>().movieMovieDay;
    super.build(context);
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: movieMovieDay!.results.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
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
                        height: 220.0,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          border: Border(),
                        ),
                      )),
                  Image.network(
                      "http://image.tmdb.org/t/p//original/${movieMovieDay!.results[index].backdropPath.toString()}"),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                movieMovieDay!.results[index].title.toString(),
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 32.0,
              )
            ],
          );
        });
  }
}
