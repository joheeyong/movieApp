// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../model/Episodes.dart';
import '../../model/movie.dart';
import '../../viewModel/homeViewModel.dart';
import 'EpisodeBox.dart';

class EpisodeComponent extends StatefulWidget {
  final Results? results;
  final int? numberOfSeasons;

  const EpisodeComponent(this.results, this.numberOfSeasons, {super.key});

  @override
  State<EpisodeComponent> createState() => EpisodeComponentState();
}

class EpisodeComponentState extends State<EpisodeComponent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Episodes? episodes;
  int seasonNumber = 0;

  @override
  void initState() {
    super.initState();

    getData(1);
  }

  getData(int season) async {
    episodes = await context
        .read<HomeViewModel>()
        .tvEpisodes(widget.results!.id, season);
    if (mounted) {
      setState(() {});
    }
  }

  Widget _seasonDropdown(int seasonNumber) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade900),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Season ${seasonNumber + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                const Icon(
                  LucideIcons.chevronDown,
                  size: 14.0,
                )
              ],
            ),
            onPressed: () {
              _openSeasonSelector();
            }),
      ],
    );
  }

  void _openSeasonSelector() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.45),
      pageBuilder: (BuildContext context, Animation<double> anim1,
          Animation<double> anim2) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return true;
          },
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(.9),
            body: Center(
              child: ListView.builder(
                itemCount: widget.numberOfSeasons,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  var season = index + 1;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Season $season',
                          style: seasonNumber + 1 == season
                              ? const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w800)
                              : const TextStyle(
                                  color: Colors.grey, fontSize: 18.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        seasonNumber = season - 1;
                        getData(season);
                      },
                    ),
                  );
                }),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close)),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        );
      },
    ).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _seasonDropdown(seasonNumber),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: episodes != null ? episodes!.episodes.length : 10,
            itemBuilder: (context, index) {
              return episodes == null
                  ? Container(
                      height: 50,
                    )
                  : EpisodeBox(
                      episode: episodes!.episodes[index],
                      fill: true,
                      padding: EdgeInsets.zero);
            })
      ],
    );
  }
}
