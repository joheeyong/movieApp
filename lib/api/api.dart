import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/movie.dart';
import '../util/var.dart';

class APIInterface {

  Future<Movie> getTrending() async {
    var result = await http.get(
        Uri.parse('${Var.baseUrl}/trending/all/week?api_key=${Var.apiKey}'));
    var body = jsonDecode(utf8.decode(result.bodyBytes));

    return Movie.fromJson(body);
  }
}
