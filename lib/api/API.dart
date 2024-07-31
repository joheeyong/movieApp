// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/Episodes.dart';
import '../model/movie.dart';
import '../util/var.dart';

class APIInterface {
  Future<Movie> getTrending(type, time) async {
    var result = await http.get(Uri.parse(
        '${baseUrl}/trending/$type/$time?api_key=${apiKey}&language=ko-KR'));
    var body = jsonDecode(utf8.decode(result.bodyBytes));

    return Movie.fromJson(body);
  }

  Future<Movie> getDiscover() async {
    var result = await http.get(Uri.parse(
        '${baseUrl}/discover/movie?api_key=${apiKey}&language=ko-KR'));
    var body = jsonDecode(utf8.decode(result.bodyBytes));

    return Movie.fromJson(body);
  }

  Future<Results> getDetails(String id, String type) async {
    var result = await http.get(
        Uri.parse('${baseUrl}/$type/$id?api_key=${apiKey}&language=ko-KR'));
    var body = jsonDecode(utf8.decode(result.bodyBytes));

    return Results.fromJson(body);
  }

  Future<Episodes> getEpisode(String id, String type) async {
    var result = await http.get(Uri.parse(
        '${baseUrl}/tv/$id/season/$type?api_key=$apiKey&language=ko-KR'));
    var body = jsonDecode(utf8.decode(result.bodyBytes));

    return Episodes.fromJson(body);
  }

  Future<Movie> getDiscoverType(String type) async {
    var result = await http.get(Uri.parse(
        '${baseUrl}/discover/$type?api_key=${apiKey}&language=ko-KR'));
    var body = jsonDecode(utf8.decode(result.bodyBytes));

    return Movie.fromJson(body);
  }
}
