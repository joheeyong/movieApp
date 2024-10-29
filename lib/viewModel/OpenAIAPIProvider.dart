// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';

import '../api/API.dart';
import '../model/openai.dart';

class OpenAIAPIProvider extends ChangeNotifier {


  Future<Openai> chatCompletions(String title, String imageUrl) async {
    return await APIInterface().getCompletions(title, imageUrl);
  }

}
