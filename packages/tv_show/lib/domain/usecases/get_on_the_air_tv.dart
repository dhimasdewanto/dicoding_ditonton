import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/tv_show.dart';
import '../repositories/tv_repository.dart';

class GetOnTheAirTv {
  final TvRepository repo;

  GetOnTheAirTv({required this.repo});

  Future<Either<Failure, List<TvShow>>> call() {
    return repo.getOnTheAir();
  }
}
