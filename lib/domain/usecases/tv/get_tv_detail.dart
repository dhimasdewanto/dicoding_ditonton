import 'package:fpdart/fpdart.dart';

import '../../../common/failure.dart';
import '../../entities/movie_detail.dart';
import '../../repositories/tv_repository.dart';

class GetTvDetail {
  final TvRepository repo;

  GetTvDetail({required this.repo});

  Future<Either<Failure, MovieDetail>> call(int id) {
    return repo.getDetail(id);
  }
}
