import 'movie.dart';
import '../enums/show_type.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/genre.dart';

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
      ];

  Movie toMovie() => Movie(
        type: type,
        adult: adult,
        backdropPath: backdropPath,
        genreIds: genres.map((genre) => genre.id).toList(),
        id: id,
        originalTitle: originalTitle,
        overview: overview,
        popularity: 0, // TODO(dev): Add popularity in movie detail.
        posterPath: posterPath,
        releaseDate: releaseDate,
        title: title,
        video: false, // TODO(dev): Add video boolean in movie detail.
        voteAverage: voteAverage,
        voteCount: voteCount,
      );
}
