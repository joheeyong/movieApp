// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import '../model/Episodes.dart';
import '../model/movie.dart';
import '../model/openai.dart';
import '../util/var.dart';

class APIInterface {

  functionJsonDecode(http.Response result) async  {
    if(result.statusCode==200){
      return jsonDecode(utf8.decode(result.bodyBytes));
    }else{
      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.mobile)) {
      } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      } else if (connectivityResult.contains(ConnectivityResult.other)) {
      } else if (connectivityResult.contains(ConnectivityResult.none)) {
      }
      print(connectivityResult.toString());
      print("StatusFail");
      return null;
  }
  }

  Future<Movie> getTrending(type, time) async {
    var result = await http.get(Uri.parse(
        '${baseUrl}/trending/$type/$time?api_key=${apiKey}&language=ko-KR'));
    var body = jsonDecode(utf8.decode(result.bodyBytes));

    return Movie.fromJson(body);
  }

  Future<Movie?> getDiscover() async {
    var result = await http.get(Uri.parse(
        '${baseUrl}/discover/movie?api_key=${apiKey}&language=ko-KR'));

    var body =  await functionJsonDecode(result);


    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
    }



    return Movie.fromJson(body)!=null ? Movie.fromJson(body) : null;
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
                  "text": "이 영화를 볼지말지 고민중인사람을 유혹해줘. 영화제목은 ${title}. 제목으로 구분이 안될까봐 이미지도 같이 전해줄게. 이미지가 도움이되지않는다면, 이미지는 무시해도돼. 너는 한국어를 사용해야하며, 가독성도 좋게해줘. 센스있는 표현도 가능하다면 부탁할게. 하지만 억지로 센스있는 표현을 쓰지는마. (반말하지말고 존댓말로해줘)"
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
