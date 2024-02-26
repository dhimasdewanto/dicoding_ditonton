import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/watchlist.dart';
import '../repositories/watchlist_repository.dart';

class RemoveWatchlist {
  final WatchlistRepository repo;

  RemoveWatchlist({required this.repo});

  Future<Either<Failure, String>> call(Watchlist movie) {
    return repo.remove(movie);
  }
}
