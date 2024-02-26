import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../../entities/movie_detail.dart';
import '../../repositories/watchlist_repository.dart';

class SaveWatchlist {
  final WatchlistRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> call(MovieDetail movie) {
    return repository.saveDetail(movie);
  }
}
