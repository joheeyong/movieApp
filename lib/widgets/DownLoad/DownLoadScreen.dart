// ignore_for_file: unrelated_type_equality_checks, prefer_is_empty

import 'package:examproject1/widgets/DownLoad/DownloadRiverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../NewAndHot/NewAndHotTile.dart';

class DownLoadScreen extends ConsumerWidget {
  const DownLoadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(downloadMoviesProvider);

    return Scaffold(
      body: RefreshIndicator(
        color: const Color.fromRGBO(153, 153, 153, 1),
        edgeOffset: 45,
        displacement: 100,
        onRefresh: () async {
          // 강제로 재로딩
          ref.invalidate(downloadMoviesProvider);
        },
        child: moviesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => Center(child: Text('오류 발생: $e')),
          data: (movies) {
            if (movies.isEmpty) {
              return const Center(
                child: Text(
                  "저장된 영상이 없습니다.",
                  style: TextStyle(
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    fontFamily: 'Helvetica',
                    color: Colors.white,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: movies.length > 100 ? 100 : movies.length,
              itemBuilder: (context, index) {
                return NewAndHotTile(
                  movie: movies[index],
                  type: movies[index].type.toString(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}