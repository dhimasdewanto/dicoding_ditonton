import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/watchlist.dart';
import '../repositories/watchlist_repository.dart';

class SaveWatchlist {
  final WatchlistRepository repo;

  SaveWatchlist({required this.repo});

  Future<Either<Failure, String>> call(Watchlist movie) {
    return repo.save(movie);
  }
}
