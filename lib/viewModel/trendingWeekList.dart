// ignore_for_file: avoid_print

import 'package:examproject1/api/api.dart';
import 'package:examproject1/model/movie.dart';
import 'package:flutter/material.dart';

class TrendingWeekList extends ChangeNotifier {

  Movie? movie;

  parsingData() async {
   movie = await APIInterface().getTrending();
   notifyListeners();
  }

}
