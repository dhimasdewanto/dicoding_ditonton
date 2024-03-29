import 'package:equatable/equatable.dart';

import '../../domain/entities/season.dart';

class SeasonModel extends Equatable {
  final DateTime? airDate;
  final int? episodeCount;
  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  const SeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
        voteAverage,
      ];

  Season toEntity() => Season(
        airDate: airDate,
        episodeCount: episodeCount,
        id: id,
        name: name ?? "",
        overview: overview ?? "",
        posterPath: posterPath ?? "",
        seasonNumber: seasonNumber,
        voteAverage: voteAverage,
      );

  factory SeasonModel.fromMap(Map<String, dynamic> json) => SeasonModel(
        airDate:
            json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"]?.toDouble(),
      );
}
