import 'package:fpdart/fpdart.dart';

import '../../common/failure.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> call(int id) {
    return repository.getMovieDetail(id);
  }
}