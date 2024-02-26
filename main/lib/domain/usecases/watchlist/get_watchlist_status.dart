import '../../repositories/watchlist_repository.dart';

class GetWatchListStatus {
  final WatchlistRepository repo;

  GetWatchListStatus({required this.repo});

  Future<bool> call(int id) async {
    return repo.isAdded(id);
  }
}
