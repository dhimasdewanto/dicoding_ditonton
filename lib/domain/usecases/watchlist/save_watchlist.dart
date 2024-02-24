import 'package:fpdart/fpdart.dart';

import '../../../common/failure.dart';
import '../../entities/movie.dart';
import '../../repositories/watchlist_repository.dart';

class SaveWatchlist {
  final WatchlistRepository repo;

  SaveWatchlist({required this.repo});

  Future<Either<Failure, String>> call(Movie movie) {
    return repo.save(movie);
  }
}