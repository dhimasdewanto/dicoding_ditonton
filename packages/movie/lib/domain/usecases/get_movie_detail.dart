import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> call(int id) {
    return repository.getMovieDetail(id);
  }
}
