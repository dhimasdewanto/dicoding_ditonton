import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../../entities/movie.dart';
import '../../repositories/movie_repository.dart';

class GetTopRatedMovies {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call() {
    return repository.getTopRatedMovies();
  }
}
