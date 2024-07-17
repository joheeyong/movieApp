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

  Movie.fromJson(Map<String, dynamic> json){
    page = json['page'];
    results = List.from(json['results']).map((e)=>Results.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

}

class Results {
  late final String? backdropPath;
  late final int? id;
  late final String? name;
  late final String? type;
  late final String? title;
  late final String? originalTitle;
  late final String? overview;
  late final String? posterPath;
  late final String? mediaType;
  late final bool? adult;
  late final String? originalLanguage;
  late final List<int>? genreIds;
  late final double? popularity;
  late final String? releaseDate;
  late final bool? video;
  late final double? voteAverage;
  late final int? voteCount;
  late final int? runtime;
  late final int? episodes;
  late final int? seasons;
  late final bool details;

  Results({
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.type,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.runtime,


  });

  Results.fromJson(Map<String, dynamic> json){
    backdropPath = json['backdrop_path'];
    id = json['id'];
    name = json['name'];
    type = json['media_type'];
    title = json['title'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    mediaType = json['media_type'];
    adult = json['adult'];
    originalLanguage = json['original_language'];
    genreIds = json['genre_ids'] == null ? [] : List.castFrom<dynamic, int>(json['genre_ids']);
    popularity = json['popularity'];
    releaseDate = json['release_date'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    runtime = json['runtime'];
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
}