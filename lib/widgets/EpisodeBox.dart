import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../model/Episodes.dart';

class EpisodeBox extends StatelessWidget {
  const EpisodeBox(
      {super.key,
      required this.episode,
      this.laughs,
      this.fill = false,
      this.padding});

  final Episode episode;
  final int? laughs;
  final bool fill;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Container(
                  margin: const EdgeInsets.all(8),
                  child: GestureDetector(
                      onTap: () {
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "http://image.tmdb.org/t/p//original/${episode.stillPath}",
                            height: 70,
                          )))),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${episode.episodeNumber}. ${episode.name}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '58m',
                    style:
                        TextStyle(fontSize: 12.0, color: Colors.grey.shade500),
                  )
                ],
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(LucideIcons.download))
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          episode.overview ?? episode.name!,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 32.0,
        )
      ],
    );
  }
}
