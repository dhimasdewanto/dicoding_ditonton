import 'package:fpdart/fpdart.dart';

import '../../common/failure.dart';
import '../../domain/entities/movie.dart';
import '../entities/movie_detail.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, List<Movie>>> getList();
  Future<Either<Failure, String>> save(Movie movie);
  Future<Either<Failure, String>> saveDetail(MovieDetail movie);
  Future<Either<Failure, String>> remove(Movie movie);
  Future<Either<Failure, String>> removeDetail(MovieDetail movie);
  Future<bool> isAdded(int id);
}
