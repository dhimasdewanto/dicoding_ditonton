import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/movie.dart';
import '../repositories/watchlist_repository.dart';

class RemoveWatchlist {
  final WatchlistRepository repo;

  RemoveWatchlist({required this.repo});

  Future<Either<Failure, String>> call(Movie movie) {
    return repo.remove(movie);
  }
}
