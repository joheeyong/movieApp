import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../model/movie.dart';
import '../viewModel/homeViewModel.dart';
import 'NetflixBottomSheet.dart';

class DiscoverWidget extends StatelessWidget {
  DiscoverWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: movieCover?.results[context.read<HomeViewModel>().random]
                          .posterPath !=
                      null
                  ? Image.network(
                      "http://image.tmdb.org/t/p//original/${movieCover?.results[context.read<HomeViewModel>().random].posterPath}",
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    )
                  : Container()),
          Positioned(
              bottom: 0.0,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 38, vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                            minWidth: 72.0, maxWidth: 72.0),
                        child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(6.0),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 20.0),
                              child: Column(
                                children: [
                                  Icon(LucideIcons.plus),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  Text(
                                    'My List',
                                    style: TextStyle(fontSize: 12.0),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            )),
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 4.0),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black),
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Play')),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                            minWidth: 72.0, maxWidth: 72.0),
                        child: InkWell(
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
                                        movie: context
                                                .read<HomeViewModel>()
                                                .movieDiscover!
                                                .results[
                                            context
                                                .read<HomeViewModel>()
                                                .random],
                                        type: context
                                            .read<HomeViewModel>()
                                            .movieDiscover!
                                            .results[0]
                                            .type
                                            .toString());
                                  });
                            },
                            borderRadius: BorderRadius.circular(6.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 20.0),
                              child: Column(
                                children: [
                                  Icon(LucideIcons.info),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Text(
                                    'Info',
                                    style: const TextStyle(fontSize: 12.0),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            )),
                      )
                    ],
                  )))
        ],
      );
    });
  }
}
