import 'package:equatable/equatable.dart';

import '../../domain/entities/watchlist.dart';
import '../../domain/enums/show_type.dart';

class WatchlistTable extends Equatable {
  final int id;
  final String type;
  final String? title;
  final String? posterPath;
  final String? overview;

  const WatchlistTable({
    required this.id,
    required this.type,
    this.title,
    this.posterPath,
    this.overview,
  });

  factory WatchlistTable.fromEntity(Watchlist movie) => WatchlistTable(
        id: movie.id,
        type: movie.type.name,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory WatchlistTable.fromMap(Map<String, dynamic> map) => WatchlistTable(
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

  Watchlist toEntity() => Watchlist(
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
