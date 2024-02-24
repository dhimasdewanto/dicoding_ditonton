import 'package:fpdart/fpdart.dart';
import '../../common/failure.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

class GetTopRatedMovies {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call() {
    return repository.getTopRatedMovies();
  }
}