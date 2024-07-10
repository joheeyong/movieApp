import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/movie.dart';
import '../util/var.dart';

class APIInterface {

  Future<Movie> getTrending(type, time) async {

    var result = await http.get(
        Uri.parse('${Var.baseUrl}/trending/$type/$time?api_key=${Var.apiKey}&language=ko-KR'));
    var body = jsonDecode(utf8.decode(result.bodyBytes));

    print('${Var.baseUrl}/trending/$type/$time?api_key=${Var.apiKey}&language=ko-KR');

    return Movie.fromJson(body);
  }

  Future<Movie> getDiscover() async {
    var result = await http.get(
        Uri.parse('${Var.baseUrl}/discover/movie?api_key=${Var.apiKey}&language=ko-KR'));
    var body = jsonDecode(utf8.decode(result.bodyBytes));

    print('${Var.baseUrl}/discover/movie?api_key=${Var.apiKey}&language=ko-KR');

    return Movie.fromJson(body);
  }
}
