import 'package:fpdart/fpdart.dart';

import '../../common/failure.dart';
import '../../domain/entities/movie.dart';
import '../repositories/watchlist_repository.dart';

class GetWatchlistMovies {
  final WatchlistRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> call() {
    return _repository.getList();
  }
}
