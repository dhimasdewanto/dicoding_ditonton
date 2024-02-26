import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/movie.dart';
import '../repositories/watchlist_repository.dart';

class GetWatchlistItems {
  final WatchlistRepository _repository;

  GetWatchlistItems(this._repository);

  Future<Either<Failure, List<Movie>>> call() {
    return _repository.getList();
  }
}
