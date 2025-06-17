import 'package:examproject1/api/API.dart';
import 'package:examproject1/model/Episodes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EpisodeNotifier extends StateNotifier<Episodes?> {
  EpisodeNotifier(this.ref) : super(null);

  final Ref ref;

  Future<void> fetchEpisodes(int id, String type) async {
    final episodes = await APIInterface().getEpisode(id.toString(), type.toString());
    state = episodes;
  }
}

final episodeNotifierProvider = StateNotifierProvider<EpisodeNotifier, Episodes?>((ref) {
  return EpisodeNotifier(ref);
});
