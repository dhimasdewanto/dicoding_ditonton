import 'package:equatable/equatable.dart';

import '../enums/show_type.dart';

class Watchlist extends Equatable {
  const Watchlist({
    required this.type,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
  });

  final ShowType type;
  final int id;
  final String? overview;
  final String? posterPath;
  final String? title;

  @override
  List<Object?> get props => [
        type,
        id,
        overview,
        posterPath,
        title,
      ];
}
