import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/watchlist.dart';
import '../repositories/watchlist_repository.dart';

class GetWatchlistItems {
  final WatchlistRepository repo;

  GetWatchlistItems({required this.repo});

  Future<Either<Failure, List<Watchlist>>> call() {
    return repo.getList();
  }
}
