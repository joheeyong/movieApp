class Movie {
  Movie({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  late final int page;
  late final List<Results> results;
  late final int totalPages;
  late final int totalResults;

  Movie.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    results =
        List.from(json['results']).map((e) => Results.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}

class Results {
  late final String? backdropPath;
  late final int? id;
  late final String? lastAirData;
  late final String? name;
  late final String? type;
  late final String? title;
  late final String? originalTitle;
  late final String? overview;
  late final String? tagline;
  late final String? posterPath;
  late final String? mediaType;
  late final bool? adult;
  late final String? originalLanguage;
  late final double? popularity;
  late final String? releaseDate;
  late final bool? video;
  late final double? voteAverage;
  late final int? voteCount;
  late final int? runtime;
  late final int? numberOfSeasons;
  late final int? episodes;
  late final int? seasons;
  late final bool? details;
  late final String? firstAirDate;

  Results({
    required this.backdropPath,
    required this.id,
    required this.lastAirData,
    required this.name,
    required this.type,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.tagline,
    required this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.originalLanguage,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.runtime,
    required this.numberOfSeasons,
    required this.firstAirDate,
  });

  Results.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    id = json['id'];
    lastAirData = json['last_air_date'];
    name = json['name'];
    type = json['media_type'] ?? "movie";
    title = json['title'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    tagline = json['tagline'];
    posterPath = json['poster_path'];
    mediaType = json['media_type'];
    adult = json['adult'] == 1
        ? true
        : json['adult'] == 0
            ? false
            : json['adult'];
    originalLanguage = json['original_language'];
    popularity = json['popularity'];
    releaseDate = json['release_date'];
    video = json['video'] == 1
        ? true
        : json['video'] == 0
            ? false
            : json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    runtime = json['runtime'];
    numberOfSeasons = json['number_of_seasons'];
    firstAirDate = json['first_air_date'];
  }

  String getRuntime() {
    if (type == 'movie') {
      var hours = runtime! / 60,
          justHours = hours.floor(),
          minutes = ((hours - hours.floor()) * 60).floor();
      return '${justHours > 0 ? '${justHours}h' : ''}${minutes > 0 ? '${justHours > 0 ? ' ' : ''}${minutes}m' : ''}';
    }

    return episodes! < 20 ? '$episodes Episodes' : '$seasons Seasons';
  }

  Map<String, dynamic> toMap() {
    return {
      if (backdropPath != null) 'backdropPath': backdropPath,
      if (id != null) 'id': id,
      if (lastAirData != null) 'lastAirData': lastAirData,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (originalTitle != null) 'originalTitle': originalTitle,
      if (overview != null) 'overview': overview,
      if (tagline != null) 'tagline': tagline,
      if (posterPath != null) 'posterPath': posterPath,
      if (mediaType != null) 'mediaType': mediaType,
      if (adult != null) 'adult': adult,
      if (originalLanguage != null) 'originalLanguage': originalLanguage,
      if (popularity != null) 'popularity': popularity,
      if (releaseDate != null) 'releaseDate': releaseDate,
      if (video != null) 'video': video,
      if (voteAverage != null) 'voteAverage': voteAverage,
      if (voteCount != null) 'voteCount': voteCount,
      if (runtime != null) 'runtime': runtime,
      if (numberOfSeasons != null) 'numberOfSeasons': numberOfSeasons,
    };
  }
}
