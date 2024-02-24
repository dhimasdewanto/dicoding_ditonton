import 'package:fpdart/fpdart.dart';
import '../../common/failure.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movie_repository.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> call(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
