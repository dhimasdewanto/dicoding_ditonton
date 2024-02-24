import 'package:fpdart/fpdart.dart';
import '../../common/failure.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call(String query) {
    return repository.searchMovies(query);
  }
}
