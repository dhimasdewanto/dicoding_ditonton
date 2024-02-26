import 'package:core/core.dart';

import '../../data/datasources/db/database_helper.dart';
import '../models/watchlist_table.dart';

abstract class WatchlistLocalDataSource {
  Future<String> insertWatchlist(WatchlistTable movie);
  Future<String> removeWatchlist(WatchlistTable movie);
  Future<WatchlistTable?> getMovieById(int id);
  Future<List<WatchlistTable>> getWatchlistMovies();
}

class WatchlistLocalDataSourceImpl implements WatchlistLocalDataSource {
  final DatabaseHelper databaseHelper;

  WatchlistLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchlistTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchlistTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return WatchlistTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchlistTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => WatchlistTable.fromMap(data)).toList();
  }
}
