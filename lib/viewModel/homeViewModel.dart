// ignore_for_file: avoid_print

import 'package:examproject1/api/API.dart';
import 'package:examproject1/model/movie.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {

  Movie? movieTrend;

  Movie? movieDiscover;

  callTrending() async {
   movieTrend = await APIInterface().getTrending();
   notifyListeners();
  }

  callDiscover() async {
    movieDiscover = await APIInterface().getDiscover();
    notifyListeners();
  }

}
