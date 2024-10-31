// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:math';
import 'package:examproject1/api/API.dart';
import 'package:examproject1/model/Episodes.dart';
import 'package:examproject1/model/movie.dart';
import 'package:flutter/material.dart';
// import 'package:in_app_review/in_app_review.dart';

class HomeViewModel extends ChangeNotifier {
  int random = 0;

  Movie? movieDiscover;
  Movie? movieAllWeek;
  Movie? movieMovieDay;
  Movie? movieMovieWeek;
  Movie? movieTVDay;
  Movie? DiscoverTV;
  Movie? DiscoverMovie;

  callDiscover() async {
    // final InAppReview inAppReview = InAppReview.instance;
    //
    // inAppReview.openStoreListing(appStoreId: 'appStoreId', microsoftStoreId: '');
    //
    // //system reView PopUp
    // if (await inAppReview.isAvailable()) {
    //   inAppReview.requestReview();
    // }
    //
    // //openStore
    // inAppReview.openStoreListing(appStoreId: 'appStoreId', microsoftStoreId: '');

    movieDiscover = await APIInterface().getDiscover();
    random = Random().nextInt(movieDiscover!.results.length);
    notifyListeners();
  }

  trendingAllWeek() async {
    movieAllWeek = await APIInterface().getTrending("all", "week");
    notifyListeners();
  }

  trendingMovieDay() async {
    movieMovieDay = await APIInterface().getTrending("movie", "day");
    notifyListeners();
  }

  trendingMovieWeek() async {
    movieMovieWeek = await APIInterface().getTrending("movie", "week");
    notifyListeners();
  }

  trendingTVDay() async {
    movieTVDay = await APIInterface().getTrending("tv", "day");
    notifyListeners();
  }

  Future<Results> movieDetail(id, type) async {
    Results? results;
    results = await APIInterface().getDetails(id.toString(), type);
    return results;
  }

  Future<Episodes> tvEpisodes(id, season) async {
    Episodes? results;
    results = await APIInterface().getEpisode(id.toString(), season.toString());
    return results;
  }

  callDiscoverTV() async {
    DiscoverTV = await APIInterface().getDiscoverType("tv");
    notifyListeners();
  }

  callDiscoverMovie() async {
    DiscoverMovie = await APIInterface().getDiscoverType("movie");
    notifyListeners();
  }
}
