import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/tv_show.dart';
import '../repositories/tv_repository.dart';

class GetPopularTv {
  final TvRepository repo;

  GetPopularTv({required this.repo});

  Future<Either<Failure, List<TvShow>>> call() {
    return repo.getPopular();
  }
}
