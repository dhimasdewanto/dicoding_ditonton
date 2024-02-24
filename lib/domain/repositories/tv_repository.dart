import 'package:fpdart/fpdart.dart';

import '../../common/failure.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Movie>>> getOnTheAir();
  Future<Either<Failure, List<Movie>>> getPopular();
  Future<Either<Failure, List<Movie>>> getTopRated();
  Future<Either<Failure, MovieDetail>> getDetail(int id);
  Future<Either<Failure, List<Movie>>> getRecommendations(int id);
  Future<Either<Failure, List<Movie>>> search(String query);
}
