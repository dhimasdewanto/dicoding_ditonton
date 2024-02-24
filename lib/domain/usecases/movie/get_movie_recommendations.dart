import 'package:fpdart/fpdart.dart';

import '../../entities/movie.dart';
import '../../repositories/movie_repository.dart';
import '../../../common/failure.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> call(id) {
    return repository.getMovieRecommendations(id);
  }
}
