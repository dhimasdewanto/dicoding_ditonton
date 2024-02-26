import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/watchlist.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, List<Watchlist>>> getList();
  Future<Either<Failure, String>> save(Watchlist movie);
  Future<Either<Failure, String>> remove(Watchlist movie);
  Future<bool> isAdded(int id);
}
