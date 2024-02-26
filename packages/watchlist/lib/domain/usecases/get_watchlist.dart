import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/movie.dart';
import '../repositories/watchlist_repository.dart';

class GetWatchlist {
  final WatchlistRepository repo;

  GetWatchlist({required this.repo});

  Future<Either<Failure, List<Movie>>> call() {
    return repo.getList();
  }
}
