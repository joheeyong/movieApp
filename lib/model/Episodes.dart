class Episodes {
  Episodes({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.episodesId,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  final String? id;
  final DateTime? airDate;
  final List<Episode> episodes;
  final String? name;
  final String? overview;
  final int? episodesId;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  factory Episodes.fromJson(Map<String, dynamic> json){
    return Episodes(
      id: json["_id"],
      airDate: DateTime.tryParse(json["air_date"] ?? ""),
      episodes: json["episodes"] == null ? [] : List<Episode>.from(json["episodes"]!.map((x) => Episode.fromJson(x))),
      name: json["name"],
      overview: json["overview"],
      episodesId: json["id"],
      posterPath: json["poster_path"],
      seasonNumber: json["season_number"],
      voteAverage: json["vote_average"],
    );
  }

}

class Episode {
  Episode({
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
    required this.crew,
    required this.guestStars,
  });

  final DateTime? airDate;
  final int? episodeNumber;
  final String? episodeType;
  final int? id;
  final String? name;
  final String? overview;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final int? showId;
  final String? stillPath;
  final double? voteAverage;
  final int? voteCount;
  final List<dynamic> crew;
  final List<GuestStar> guestStars;

  factory Episode.fromJson(Map<String, dynamic> json){
    return Episode(
      airDate: DateTime.tryParse(json["air_date"] ?? ""),
      episodeNumber: json["episode_number"],
      episodeType: json["episode_type"],
      id: json["id"],
      name: json["name"],
      overview: json["overview"],
      productionCode: json["production_code"],
      runtime: json["runtime"],
      seasonNumber: json["season_number"],
      showId: json["show_id"],
      stillPath: json["still_path"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
      crew: json["crew"] == null ? [] : List<dynamic>.from(json["crew"]!.map((x) => x)),
      guestStars: json["guest_stars"] == null ? [] : List<GuestStar>.from(json["guest_stars"]!.map((x) => GuestStar.fromJson(x))),
    );
  }

}

class GuestStar {
  GuestStar({
    required this.character,
    required this.creditId,
    required this.order,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
  });

  final String? character;
  final String? creditId;
  final int? order;
  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;

  factory GuestStar.fromJson(Map<String, dynamic> json){
    return GuestStar(
      character: json["character"],
      creditId: json["credit_id"],
      order: json["order"],
      adult: json["adult"],
      gender: json["gender"],
      id: json["id"],
      knownForDepartment: json["known_for_department"],
      name: json["name"],
      originalName: json["original_name"],
      popularity: json["popularity"],
      profilePath: json["profile_path"],
    );
  }

}
