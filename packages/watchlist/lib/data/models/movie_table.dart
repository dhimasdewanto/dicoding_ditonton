import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/enums/show_type.dart';

class MovieTable extends Equatable {
  final int id;
  final String type;
  final String? title;
  final String? posterPath;
  final String? overview;

  const MovieTable({
    required this.id,
    required this.type,
    this.title,
    this.posterPath,
    this.overview,
  });

  factory MovieTable.fromMovie(Movie movie) => MovieTable(
        id: movie.id,
        type: movie.type.name,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
        id: movie.id,
        type: movie.type.name,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        type: map['type'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        type: getTypeFromName(type),
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        posterPath,
        overview,
      ];
}
