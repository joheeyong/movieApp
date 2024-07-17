import 'package:examproject1/widgets/MovieDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../model/movie.dart';
import '../viewModel/homeViewModel.dart';

class NetflixBottomSheet extends StatefulWidget {
  final Results movie;
  NetflixBottomSheet({super.key, required this.movie});

  @override
  State<NetflixBottomSheet> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NetflixBottomSheet> {
  late Results movie;
  @override
  void initState() {
    super.initState();

    movie = widget.movie;
    parsingData();

  }

  parsingData() async {
    movie = await context.read<HomeViewModel>().movieDetail(movie.id, movie.type);
    setState(() {
    });
  }

  final _shimmer = Shimmer(
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
    child: Row(
      children: const [
        Text(
          '2022',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(
          '18+',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(
          '10 Episodes',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        "http://image.tmdb.org/t/p//w154/${movie.posterPath.toString()}",
                      )),
                ],
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            textDirection: TextDirection.ltr,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                movie.title == null ? movie.name.toString() : movie.title.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    movie.releaseDate.toString(),
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  const Text(
                                    '18+',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  // Text(
                                  //   movie.getRuntime() ??
                                  //       '10 Episodes',
                                  //   style: const TextStyle(
                                  //       color: Colors.grey,
                                  //       fontSize: 14.0),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(100.0),
                          radius: 32.0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff3d3d3d),
                                borderRadius:
                                BorderRadius.circular(100.0)),
                            child: const Icon(
                              LucideIcons.x,
                              size: 28.0,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      movie.overview.toString(),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(
                Icons.play_arrow,
                size: 24,
                color: Colors.black
              ),
              Icon(
                LucideIcons.download,
                  size: 24,
                  color: Colors.black
              ),
              Icon(
                LucideIcons.plus,
                  size: 24,
                  color: Colors.black
              ),
              Icon(
                LucideIcons.share2,
                  size: 24,
                  color: Colors.black
              ),
            ],
          ),
          const Divider(),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MovieDetailsScreen( movie: movie,)

              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(LucideIcons.info),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(movie.type == 'tv'
                        ? 'Episodes & Info'
                        : 'Details & More'),
                  ],
                ),
                const Icon(LucideIcons.chevronRight)
              ],
            ),
          )
        ],
      ),
    );
  }
}
