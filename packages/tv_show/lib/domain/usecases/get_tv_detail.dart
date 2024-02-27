import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/tv_show_detail.dart';
import '../repositories/tv_repository.dart';

class GetTvDetail {
  final TvRepository repo;

  GetTvDetail({required this.repo});

  Future<Either<Failure, TvShowDetail>> call(int id) {
    return repo.getDetail(id);
  }
}
