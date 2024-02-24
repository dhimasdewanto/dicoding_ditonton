import 'package:fpdart/fpdart.dart';

import '../../../common/failure.dart';
import '../../entities/movie.dart';
import '../../repositories/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository repo;

  GetTvRecommendations({required this.repo});

  Future<Either<Failure, List<Movie>>> call(id) {
    return repo.getRecommendations(id);
  }
}
