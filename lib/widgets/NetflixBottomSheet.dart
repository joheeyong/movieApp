// ignore_for_file: non_constant_identifier_names

import 'package:examproject1/widgets/MovieDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../model/movie.dart';
import '../viewModel/homeViewModel.dart';

class NetflixBottomSheet extends StatefulWidget {
  final Results movie;

  const NetflixBottomSheet({super.key, required this.movie});

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
    movie =
        await context.read<HomeViewModel>().movieDetail(movie.id, movie.type);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("NetfixBottomSheet.dart");
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
                        width: 120,
                        height: 180,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? ImgloadingProgress) {
                          if (ImgloadingProgress == null) {
                            return child;
                          } else {
                            return Container(
                              width: 120.0,
                              height: 180.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.grey),
                              child: Container(),
                            );
                          }
                        },
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
                                movie.title == null
                                    ? movie.name.toString()
                                    : movie.title.toString(),
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
                                    movie.releaseDate == null
                                        ? ""
                                        : movie.releaseDate.toString(),
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    movie.adult == true ? '18+' : '',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 14.0),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
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
                                color: const Color(0xff3d3d3d),
                                borderRadius: BorderRadius.circular(100.0)),
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
          const Divider(),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MovieDetailsScreen(
                            movie: movie,
                          )));
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(LucideIcons.info),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text("자세히보기"),
                  ],
                ),
                Icon(LucideIcons.chevronRight)
              ],
            ),
          )
        ],
      ),
    );
  }
}
