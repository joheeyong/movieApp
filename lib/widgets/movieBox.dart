import 'package:flutter/material.dart';
import '../model/movie.dart';
import 'NetflixBottomSheet.dart';

class MovieBox extends StatelessWidget {
  final Results? results;

  const MovieBox(this.results, {super.key});

  @override
  Widget build(BuildContext context) {
    print("MovieBox.dart");
    return Container(
      margin: const EdgeInsets.all(8),
        child: GestureDetector(
            onTap: (){
              showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  backgroundColor: const Color(0xff2b2b2b),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                  ),
                  builder: (context) {
                    return NetflixBottomSheet(
                      movie: results!,
                    );
                  });
            },
            child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              "http://image.tmdb.org/t/p//w154/${results?.posterPath.toString()}",
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? ImgloadingProgress) {
                  if (ImgloadingProgress == null) {
                    return child;
                  } else {
                    return Container(
                      width: 110.0,
                      height: 220.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey),
                      child: Container(),
                    );
                  }
                },
                errorBuilder: (
                    BuildContext context,
                    Object error,
                    StackTrace? stackTrace,
                    ) {
                  return Container(
                    width: 110.0,
                    height: 220.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey),
                    child: Container(),
                  );
                }
            ))));
  }
}
