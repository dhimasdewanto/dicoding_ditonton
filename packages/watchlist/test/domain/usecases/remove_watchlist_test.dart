import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:watchlist/domain/repositories/watchlist_repository.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late RemoveWatchlist usecase;
  late WatchlistRepository repo;

  setUp(() {
    repo = MockWatchlistRepository();
    usecase = RemoveWatchlist(repo: repo);
  });

  test('Should remove watchlist item from repository', () async {
    // arrange
    when(() => repo.remove(testItem))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase(testItem);
    // assert
    verify(() => repo.remove(testItem));
    expect(result, const Right('Removed from watchlist'));
  });
}
