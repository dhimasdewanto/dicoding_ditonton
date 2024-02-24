import '../repositories/watchlist_repository.dart';

class GetWatchListStatus {
  final WatchlistRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> call(int id) async {
    return repository.isAdded(id);
  }
}
