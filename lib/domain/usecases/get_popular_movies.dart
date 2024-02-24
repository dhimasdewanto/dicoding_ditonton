import 'package:fpdart/fpdart.dart';
import '../../common/failure.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call() {
    return repository.getPopularMovies();
  }
}
