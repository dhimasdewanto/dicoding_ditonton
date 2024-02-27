import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/tv_show.dart';
import '../repositories/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository repo;

  GetTvRecommendations({required this.repo});

  Future<Either<Failure, List<TvShow>>> call(id) {
    return repo.getRecommendations(id);
  }
}
