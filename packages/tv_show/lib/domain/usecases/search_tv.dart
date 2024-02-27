import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/tv_show.dart';
import '../repositories/tv_repository.dart';

class SearchTv {
  final TvRepository repo;

  SearchTv({required this.repo});

  Future<Either<Failure, List<TvShow>>> call(String query) {
    return repo.search(query);
  }
}
