import 'movie.dart';
import '../enums/show_type.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/genre.dart';
import 'season.dart';

class MovieDetail extends Equatable {
  const MovieDetail({
    required this.type,
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.seasons,
  });

  final ShowType type;
  final bool adult;
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final String title;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final List<Season> seasons;

  @override
  List<Object?> get props => [
        type,
        adult,
        backdropPath,
        genres,
        id,
        originalTitle,
        overview,
        posterPath,
        releaseDate,
        title,
        voteAverage,
        voteCount,
        seasons,
      ];

  Movie toMovie() => Movie(
        type: type,
        adult: adult,
        backdropPath: backdropPath,
        genreIds: genres.map((genre) => genre.id).toList(),
        id: id,
        originalTitle: originalTitle,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        releaseDate: releaseDate,
        title: title,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );
}
