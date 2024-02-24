import 'package:fpdart/fpdart.dart';

import '../../common/failure.dart';
import '../../domain/entities/movie_detail.dart';
import '../repositories/watchlist_repository.dart';

class RemoveWatchlist {
  final WatchlistRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> call(MovieDetail movie) {
    return repository.removeDetail(movie);
  }
}
