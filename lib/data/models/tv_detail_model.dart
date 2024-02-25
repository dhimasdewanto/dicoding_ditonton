import 'package:equatable/equatable.dart';

import '../../domain/entities/movie_detail.dart';
import 'genre_model.dart';

class TvDetailModel extends Equatable {
  final bool adult;
  final String backdropPath;
  // final List<CreatedBy> createdBy;
  final List<dynamic> episodeRunTime;
  final DateTime firstAirDate;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final DateTime lastAirDate;
  // final LastEpisodeToAir? lastEpisodeToAir;
  final String name;
  final dynamic nextEpisodeToAir;
  // final List<Network> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  // final List<Network> productionCompanies;
  // final List<ProductionCountry> productionCountries;
  // final List<Season> seasons;
  // final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  const TvDetailModel({
    required this.adult,
    required this.backdropPath,
    // required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    // required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    // required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    // required this.productionCompanies,
    // required this.productionCountries,
    // required this.seasons,
    // required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  MovieDetail toEntity() {
    return MovieDetail(
      adult: adult,
      backdropPath: backdropPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      originalTitle: originalName,
      overview: overview,
      posterPath: posterPath,
      releaseDate: firstAirDate.toString(),
      runtime: numberOfEpisodes,
      title: name,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        // createdBy,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        // lastEpisodeToAir,
        name,
        nextEpisodeToAir,
        // networks,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        // productionCompanies,
        // productionCountries,
        // seasons,
        // spokenLanguages,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];

  factory TvDetailModel.fromMap(Map<String, dynamic> json) => TvDetailModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        // createdBy: List<CreatedBy>.from(
        //     json["created_by"].map((x) => CreatedBy.fromMap(x))),
        episodeRunTime:
            List<dynamic>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: DateTime.parse(json["last_air_date"]),
        // lastEpisodeToAir: LastEpisodeToAir.fromMap(json["last_episode_to_air"]),
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"],
        // networks:
        //     List<Network>.from(json["networks"].map((x) => Network.fromMap(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        // productionCompanies: List<Network>.from(
        //     json["production_companies"].map((x) => Network.fromMap(x))),
        // productionCountries: List<ProductionCountry>.from(
        //     json["production_countries"]
        //         .map((x) => ProductionCountry.fromMap(x))),
        // seasons:
        //     List<Season>.from(json["seasons"].map((x) => Season.fromMap(x))),
        // spokenLanguages: List<SpokenLanguage>.from(
        //     json["spoken_languages"].map((x) => SpokenLanguage.fromMap(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toMap() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        // "created_by": List<dynamic>.from(createdBy.map((x) => x.toMap())),
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date":
            "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "last_air_date":
            "${lastAirDate.year.toString().padLeft(4, '0')}-${lastAirDate.month.toString().padLeft(2, '0')}-${lastAirDate.day.toString().padLeft(2, '0')}",
        // "last_episode_to_air": lastEpisodeToAir?.toMap(),
        "name": name,
        "next_episode_to_air": nextEpisodeToAir,
        // "networks": List<dynamic>.from(networks.map((x) => x.toMap())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        // "production_companies":
        //     List<dynamic>.from(productionCompanies.map((x) => x.toMap())),
        // "production_countries":
        //     List<dynamic>.from(productionCountries.map((x) => x.toMap())),
        // "seasons": List<dynamic>.from(seasons.map((x) => x.toMap())),
        // "spoken_languages":
        //     List<dynamic>.from(spokenLanguages.map((x) => x.toMap())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

// class CreatedBy extends Equatable {
//   final int id;
//   final String creditId;
//   final String name;
//   final int gender;
//   final String profilePath;

//   const CreatedBy({
//     required this.id,
//     required this.creditId,
//     required this.name,
//     required this.gender,
//     required this.profilePath,
//   });

//   @override
//   List<Object?> get props => [
//         id,
//         creditId,
//         name,
//         gender,
//         profilePath,
//       ];

//   factory CreatedBy.fromMap(Map<String, dynamic> json) => CreatedBy(
//         id: json["id"],
//         creditId: json["credit_id"],
//         name: json["name"],
//         gender: json["gender"],
//         profilePath: json["profile_path"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "credit_id": creditId,
//         "name": name,
//         "gender": gender,
//         "profile_path": profilePath,
//       };
// }

// class LastEpisodeToAir extends Equatable {
//   final int id;
//   final String name;
//   final String overview;
//   final double voteAverage;
//   final int voteCount;
//   final DateTime airDate;
//   final int episodeNumber;
//   final String episodeType;
//   final String productionCode;
//   final int runtime;
//   final int seasonNumber;
//   final int showId;
//   final String stillPath;

//   const LastEpisodeToAir({
//     required this.id,
//     required this.name,
//     required this.overview,
//     required this.voteAverage,
//     required this.voteCount,
//     required this.airDate,
//     required this.episodeNumber,
//     required this.episodeType,
//     required this.productionCode,
//     required this.runtime,
//     required this.seasonNumber,
//     required this.showId,
//     required this.stillPath,
//   });

//   @override
//   List<Object?> get props => [
//         id,
//         name,
//         overview,
//         voteAverage,
//         voteCount,
//         airDate,
//         episodeNumber,
//         episodeType,
//         productionCode,
//         runtime,
//         seasonNumber,
//         showId,
//         stillPath,
//       ];

//   factory LastEpisodeToAir.fromMap(Map<String, dynamic> json) =>
//       LastEpisodeToAir(
//         id: json["id"],
//         name: json["name"],
//         overview: json["overview"],
//         voteAverage: json["vote_average"]?.toDouble(),
//         voteCount: json["vote_count"],
//         airDate: DateTime.parse(json["air_date"]),
//         episodeNumber: json["episode_number"],
//         episodeType: json["episode_type"],
//         productionCode: json["production_code"],
//         runtime: json["runtime"],
//         seasonNumber: json["season_number"],
//         showId: json["show_id"],
//         stillPath: json["still_path"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//         "overview": overview,
//         "vote_average": voteAverage,
//         "vote_count": voteCount,
//         "air_date":
//             "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
//         "episode_number": episodeNumber,
//         "episode_type": episodeType,
//         "production_code": productionCode,
//         "runtime": runtime,
//         "season_number": seasonNumber,
//         "show_id": showId,
//         "still_path": stillPath,
//       };
// }

// class Network extends Equatable {
//   final int id;
//   final String logoPath;
//   final String name;
//   final String originCountry;

//   const Network({
//     required this.id,
//     required this.logoPath,
//     required this.name,
//     required this.originCountry,
//   });

//   @override
//   List<Object?> get props => [
//         id,
//         logoPath,
//         name,
//         originCountry,
//       ];

//   factory Network.fromMap(Map<String, dynamic> json) => Network(
//         id: json["id"],
//         logoPath: json["logo_path"] ?? "",
//         name: json["name"],
//         originCountry: json["origin_country"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "logo_path": logoPath,
//         "name": name,
//         "origin_country": originCountry,
//       };
// }

// class ProductionCountry extends Equatable {
//   final String iso31661;
//   final String name;

//   const ProductionCountry({
//     required this.iso31661,
//     required this.name,
//   });

//   @override
//   List<Object?> get props => [
//         iso31661,
//         name,
//       ];

//   factory ProductionCountry.fromMap(Map<String, dynamic> json) =>
//       ProductionCountry(
//         iso31661: json["iso_3166_1"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toMap() => {
//         "iso_3166_1": iso31661,
//         "name": name,
//       };
// }

// class Season extends Equatable {
//   final DateTime airDate;
//   final int episodeCount;
//   final int id;
//   final String name;
//   final String overview;
//   final String posterPath;
//   final int seasonNumber;
//   final double voteAverage;

//   const Season({
//     required this.airDate,
//     required this.episodeCount,
//     required this.id,
//     required this.name,
//     required this.overview,
//     required this.posterPath,
//     required this.seasonNumber,
//     required this.voteAverage,
//   });

//   @override
//   List<Object?> get props => [
//         airDate,
//         episodeCount,
//         id,
//         name,
//         overview,
//         posterPath,
//         seasonNumber,
//         voteAverage,
//       ];

//   factory Season.fromMap(Map<String, dynamic> json) => Season(
//         airDate: DateTime.parse(json["air_date"]),
//         episodeCount: json["episode_count"],
//         id: json["id"],
//         name: json["name"],
//         overview: json["overview"],
//         posterPath: json["poster_path"],
//         seasonNumber: json["season_number"],
//         voteAverage: json["vote_average"]?.toDouble(),
//       );

//   Map<String, dynamic> toMap() => {
//         "air_date":
//             "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
//         "episode_count": episodeCount,
//         "id": id,
//         "name": name,
//         "overview": overview,
//         "poster_path": posterPath,
//         "season_number": seasonNumber,
//         "vote_average": voteAverage,
//       };
// }

// class SpokenLanguage extends Equatable {
//   final String englishName;
//   final String iso6391;
//   final String name;

//   const SpokenLanguage({
//     required this.englishName,
//     required this.iso6391,
//     required this.name,
//   });

//   @override
//   List<Object?> get props => [
//         englishName,
//         iso6391,
//         name,
//       ];

//   factory SpokenLanguage.fromMap(Map<String, dynamic> json) => SpokenLanguage(
//         englishName: json["english_name"],
//         iso6391: json["iso_639_1"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toMap() => {
//         "english_name": englishName,
//         "iso_639_1": iso6391,
//         "name": name,
//       };
// }
