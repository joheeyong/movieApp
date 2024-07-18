import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../model/movie.dart';
import '../viewModel/homeViewModel.dart';
import 'movieBox.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, required this.movie});

  final Results movie;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen>     with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return _buildDetails(widget.movie);
  }

  Widget _buildDetails(Results movie) {
    return Scaffold(body: CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(LucideIcons.cast),
              onPressed: () {},
            ),
          ],
          pinned: true,
        ),
        SliverList(
            delegate: SliverChildListDelegate.fixed([
              Stack(
                children: [
                  Image.network("http://image.tmdb.org/t/p//w780/${widget.movie.backdropPath}",),
                  Positioned(
                      bottom: 12.0,
                      left: 6.0,
                      child: SizedBox(
                        height: 32.0,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.0)),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black.withOpacity(.3)),
                            onPressed: () {},
                            child: const Text('Preview')),
                      )),
                  Positioned(
                      bottom: 6.0,
                      right: 6.0,
                      child: IconButton(
                          onPressed: () {}, icon: const Icon(LucideIcons.volumeX)))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.movie.title.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 32.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      widget.movie.releaseDate.toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.grey.shade700),
                        child: const Text(
                          '16+',
                          style: TextStyle(letterSpacing: 1.0),
                        )),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "${movie.runtime}분",
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            color: Colors.grey.shade300),
                        child: const Text(
                          'HD',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black),
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Play')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        backgroundColor: Colors.grey.shade900,
                        foregroundColor: Colors.white),
                    onPressed: () {},
                    icon: const Icon(LucideIcons.download),
                    label: const Text('Download')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(movie.tagline.toString(), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(movie.overview.toString()),
                    const SizedBox(
                      height: 24.0,
                    ),
                  ],
                ),
              ),
              const Text(
                '다른 영상',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(
                height: 180.0,
                child: Builder(builder: (context) {
                  Movie? movieTrend = context.watch<HomeViewModel>().movieAllWeek;

                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movieTrend?.results.length,
                        itemBuilder: (context, index) {
                          return MovieBox(movieTrend?.results[index]);
                        });

                }),
              ),
              const Divider(
                height: 1.0,
              ),
            ])),
      ],
    ));
  }

}