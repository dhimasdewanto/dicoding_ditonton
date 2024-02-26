import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';

import '../datasources/watchlist_local_data_source.dart';
import '../models/watchlist_table.dart';
import '../../domain/entities/watchlist.dart';
import '../../domain/repositories/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistLocalDataSource localDataSource;

  WatchlistRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, String>> save(Watchlist movie) async {
    try {
      final result =
          await localDataSource.insertWatchlist(WatchlistTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> remove(Watchlist movie) async {
    try {
      final result =
          await localDataSource.removeWatchlist(WatchlistTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAdded(int id) async {
    final result = await localDataSource.getMovieById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Watchlist>>> getList() async {
    final result = await localDataSource.getWatchlistMovies();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
