import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call() {
    return repository.getNowPlayingMovies();
  }
}
