import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/tv_show.dart';
import '../repositories/tv_repository.dart';

class GetTopRatedTv {
  final TvRepository repo;

  GetTopRatedTv({required this.repo});

  Future<Either<Failure, List<TvShow>>> call() {
    return repo.getTopRated();
  }
}
