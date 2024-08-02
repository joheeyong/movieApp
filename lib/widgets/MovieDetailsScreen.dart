import 'package:examproject1/widgets/Episode/EpisodeComponent.dart';
import 'package:examproject1/widgets/MoreLike/MoreLikeComponent.dart';
import 'package:examproject1/widgets/trandWidget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';
import '../model/movie.dart';
import 'DownLoad/recentItemVIewDatabaseHelper.dart';
import 'Trailer/TrailerComponent.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen(
      {super.key, required this.movie, required this.type});

  final Results movie;
  final String type;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen>
    with SingleTickerProviderStateMixin {
  int tapIndex = 0;
  late final TabController tabController =
      TabController(length: widget.type == 'tv' ? 3 : 2, vsync: this)
        ..addListener(() {
          setState(() {
            tapIndex = tabController.index;
          });
        });

  late TabBarView tabBarView;

  @override
  void initState() {
    super.initState();
    setSQLite();
  }

  setSQLite() async {
    print(widget.type);
    await instance.delete(Results(
      backdropPath: widget.movie.backdropPath,
      id: widget.movie.id,
      lastAirData: widget.movie.lastAirData,
      name: widget.movie.name,
      type: widget.type,
      title:  widget.movie.title.toString() == "null"
          ? widget.movie.name.toString()
          : widget.movie.title.toString(),
      originalTitle: widget.movie.originalTitle,
      overview: widget.movie.overview,
      tagline: widget.movie.tagline,
      posterPath: widget.movie.posterPath,
      mediaType: widget.movie.mediaType,
      adult: widget.movie.adult,
      originalLanguage: widget.movie.originalLanguage,
      popularity: widget.movie.popularity,
      releaseDate: widget.movie.releaseDate,
      video: widget.movie.video,
      voteAverage: widget.movie.voteAverage,
      voteCount: widget.movie.voteCount,
      runtime: widget.movie.runtime,
      numberOfSeasons: widget.movie.numberOfSeasons,
      firstAirDate: widget.movie.firstAirDate,
    ));

    await instance.add(Results(
      backdropPath: widget.movie.backdropPath,
      id: widget.movie.id,
      lastAirData: widget.movie.lastAirData,
      name: widget.movie.name,
      type: widget.type,
      title:  widget.movie.title.toString() == "null"
          ? widget.movie.name.toString()
          : widget.movie.title.toString(),
      originalTitle: widget.movie.originalTitle,
      overview: widget.movie.overview,
      tagline: widget.movie.tagline,
      posterPath: widget.movie.posterPath,
      mediaType: widget.movie.mediaType,
      adult: widget.movie.adult,
      originalLanguage: widget.movie.originalLanguage,
      popularity: widget.movie.popularity,
      releaseDate: widget.movie.releaseDate,
      video: widget.movie.video,
      voteAverage: widget.movie.voteAverage,
      voteCount: widget.movie.voteCount,
      runtime: widget.movie.runtime,
      numberOfSeasons: widget.movie.numberOfSeasons,
      firstAirDate: widget.movie.firstAirDate,
    ));

  }

  @override
  Widget build(BuildContext context) {
    return buildDetails(widget.movie);
  }

  Widget buildDetails(Results movie) {
    return Scaffold(
        body: CustomScrollView(
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
                    height: 220,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      border: Border(),
                    ),
                  )),
              Image.network(
                "http://image.tmdb.org/t/p//w780/${widget.movie.backdropPath}",
              ),
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
              widget.movie.title.toString() == "null"
                  ? widget.movie.name.toString()
                  : widget.movie.title.toString(),
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
                Visibility(
                    visible: widget.movie.releaseDate.toString() != 'null' ||
                        widget.movie.lastAirData.toString() != 'null',
                    child: Text(
                      widget.movie.releaseDate.toString() == "null"
                          ? widget.movie.lastAirData.toString()
                          : widget.movie.releaseDate.toString(),
                      style: const TextStyle(color: Colors.grey),
                    )),
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
                  movie.runtime.toString() == "null"
                      ? "${movie.numberOfSeasons} Seasons"
                      : "${movie.runtime}분",
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
                Text(movie.tagline.toString(),
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w800)),
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
          TrandWidget("allWeek"),
          const Divider(
            height: 1.0,
          ),
          TabBar(
              controller: tabController,
              indicator: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                  color: Color(0xffe50914),
                  width: 4.0,
                )),
              ),
              tabs: [
                if (widget.type == 'tv')
                  const Tab(
                    text: '에피소드',
                  ),
                const Tab(
                  text: '관련 영상',
                ),
                const Tab(
                  text: '추천콘텐츠',
                ),
              ]),
          tabController.index == 0 && widget.type == 'tv'
              ? EpisodeComponent(widget.movie, widget.movie.numberOfSeasons)
              : tabController.index == 1 && widget.type == 'tv' ||
                      tabController.index == 0 && widget.type == "movie"
                  ? const TrailerComponent()
                  : const MoreLikeComponent()
        ])),
      ],
    ));
  }
}
