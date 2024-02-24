import 'package:fpdart/fpdart.dart';

import '../../../common/failure.dart';
import '../../entities/movie.dart';
import '../../repositories/tv_repository.dart';

class GetTopRatedTv {
  final TvRepository repo;

  GetTopRatedTv({required this.repo});

  Future<Either<Failure, List<Movie>>> call() {
    return repo.getTopRated();
  }
}
