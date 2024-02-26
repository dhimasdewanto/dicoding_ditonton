import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../../entities/movie.dart';
import '../../repositories/tv_repository.dart';

class SearchTv {
  final TvRepository repo;

  SearchTv({required this.repo});

  Future<Either<Failure, List<Movie>>> call(String query) {
    return repo.search(query);
  }
}
