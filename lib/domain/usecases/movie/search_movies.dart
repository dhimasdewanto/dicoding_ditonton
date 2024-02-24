import 'package:fpdart/fpdart.dart';
import '../../../common/failure.dart';
import '../../entities/movie.dart';
import '../../repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call(String query) {
    return repository.searchMovies(query);
  }
}
