import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../../entities/movie.dart';
import '../../repositories/tv_repository.dart';

class GetPopularTv {
  final TvRepository repo;

  GetPopularTv({required this.repo});

  Future<Either<Failure, List<Movie>>> call() {
    return repo.getPopular();
  }
}
