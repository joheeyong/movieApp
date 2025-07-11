import 'package:examproject1/widgets/Episode/EpisodeRiverpod.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../model/movie.dart';
import 'EpisodeBox.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EpisodeComponent extends ConsumerStatefulWidget {
  final Results? results;
  final int? numberOfSeasons;

  const EpisodeComponent(this.results, this.numberOfSeasons, {super.key});

  @override
  ConsumerState<EpisodeComponent> createState() => EpisodeComponentState();
}

class EpisodeComponentState extends ConsumerState<EpisodeComponent> {
  int seasonNumber = 0;

  @override
  void initState() {
    super.initState();
    _fetchEpisodes(); // 초기 데이터 로드
  }

  void _fetchEpisodes() {
    if (widget.results != null) {
      ref.read(episodeNotifierProvider.notifier).fetchEpisodes(widget.results!.id!, seasonNumber.toString());
    }
  }

  void _onSeasonSelected(int selectedSeason) {
    setState(() {
      seasonNumber = selectedSeason - 1;
    });
    _fetchEpisodes();
  }

  Widget _seasonDropdown(int seasonNumber) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade900),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Season ${seasonNumber + 1}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8.0),
          const Icon(LucideIcons.chevronDown, size: 14.0),
        ],
      ),
      onPressed: _openSeasonSelector,
    );
  }

  void _openSeasonSelector() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.45),
      pageBuilder: (context, anim1, anim2) {
        return Scaffold(
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
                    onTap: () {
                      Navigator.pop(context);
                      _onSeasonSelected(season);
                    },
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
                            color: Colors.grey,
                            fontSize: 18.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () => Navigator.pop(context),
            child: const Icon(Icons.close),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final episodeData = ref.watch(episodeNotifierProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _seasonDropdown(seasonNumber),
        const SizedBox(height: 8),
        if (episodeData == null)
          const Center(child: CircularProgressIndicator())
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: episodeData.episodes.length,
            itemBuilder: (context, index) {
              final episode = episodeData.episodes[index];
              return EpisodeBox(
                episode: episode,
                fill: true,
                padding: EdgeInsets.zero,
              );
            },
          ),
      ],
    );
  }
}
