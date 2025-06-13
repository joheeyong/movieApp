import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/movie.dart';
import '../../widgets/DownLoad/recentItemVIewDatabaseHelper.dart';

final downloadMoviesProvider = FutureProvider<List<Results>>((ref) async {
  final result = await instance.getProducts();
  return result;
});
