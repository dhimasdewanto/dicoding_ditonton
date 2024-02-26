import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../../entities/movie_detail.dart';
import '../../repositories/watchlist_repository.dart';

class RemoveWatchlist {
  final WatchlistRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> call(MovieDetail movie) {
    return repository.removeDetail(movie);
  }
}
