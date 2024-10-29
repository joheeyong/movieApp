// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/Episodes.dart';
import '../model/movie.dart';
import '../model/openai.dart';
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

    print('${baseUrl}/$type/$id?api_key=${apiKey}&language=ko-KR');

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

  Future<Openai> getCompletions(String title, String image) async {
    print(image);
    var result = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer + your API key',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "model": "gpt-4o",
          "messages": [
            {
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text": "영화를 추천해주는 앱이야. 나는 너에게 영화 포스터를 줄거고 너는 사용자에게 영화의 정보를 제공할거야. 영화제목은 ${title}인것 같긴해. 이 영화에 대한 알고있는정보를 자세히 알려줘.  죄송하지만 이미지를 분석할 수는 없어요.와 같은 말은 생략해줘. 너는 한국어를 사용해야해!"
                },
                {
                  "type": "image_url",
                  "image_url": {"url": image}
                }
              ]
            }
          ]
        }));
    var body = jsonDecode(utf8.decode(result.bodyBytes));

    print(body);
    return Openai.fromJson(body);
  }
}
