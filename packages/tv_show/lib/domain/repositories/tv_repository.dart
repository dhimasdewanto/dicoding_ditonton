import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/tv_show.dart';
import '../entities/tv_show_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<TvShow>>> getOnTheAir();
  Future<Either<Failure, List<TvShow>>> getPopular();
  Future<Either<Failure, List<TvShow>>> getTopRated();
  Future<Either<Failure, TvShowDetail>> getDetail(int id);
  Future<Either<Failure, List<TvShow>>> getRecommendations(int id);
  Future<Either<Failure, List<TvShow>>> search(String query);
}
