import 'package:cached_network_image/cached_network_image.dart';
import 'package:examproject1/util/var.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/movie.dart';
import '../../viewModel/homeViewModel.dart';
import '../MovieDetailsScreen.dart';

class NewAndHotTile extends StatelessWidget {
  const NewAndHotTile({super.key, required this.movie, required this.type});

  final Results movie;
  final String type;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Results mm =
            await context.read<HomeViewModel>().movieDetail(movie.id, type);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    MovieDetailsScreen(movie: mm, type: type)));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.firstAirDate != null
                    ? "${dateFormat.parse(movie.firstAirDate.toString()).month.toString().padLeft(2, '')}월"
                    : "${dateFormat.parse(movie.releaseDate.toString()).month.toString().padLeft(2, '')}월",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.grey),
              ),
              Text(
                movie.firstAirDate != null
                    ? dateFormat
                        .parse(movie.firstAirDate.toString())
                        .day
                        .toString()
                        .padLeft(2, '')
                    : dateFormat
                        .parse(movie.releaseDate.toString())
                        .day
                        .toString()
                        .padLeft(2, ''),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 32.0),
              )
            ],
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      "http://image.tmdb.org/t/p//original/${movie.backdropPath.toString()}",
                  imageBuilder: (context, imageProvider) => ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      height: 190,
                    ),
                  ),
                  placeholder: (context, url) => Shimmer(
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.black),
                      height: 190,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 190,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey),
                    child: Image.asset(
                      'assets/netflix_symbol.png',
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    IconButton(
                      icon: const Icon(LucideIcons.bell),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.info),
                      onPressed: () {},
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.name != null ? movie.name.toString() : movie.title.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      movie.overview.toString(),
                      style: const TextStyle(color: Colors.grey),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
