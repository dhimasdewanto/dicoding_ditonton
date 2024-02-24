import 'package:fpdart/fpdart.dart';

import '../../../common/failure.dart';
import '../../entities/movie.dart';
import '../../repositories/tv_repository.dart';

class GetOnTheAirTv {
  final TvRepository repo;

  GetOnTheAirTv({required this.repo});

  Future<Either<Failure, List<Movie>>> call() {
    return repo.getOnTheAir();
  }
}
