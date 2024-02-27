import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:watchlist/domain/repositories/watchlist_repository.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late SaveWatchlist usecase;
  late WatchlistRepository repo;

  setUp(() {
    repo = MockWatchlistRepository();
    usecase = SaveWatchlist(repo: repo);
  });

  test('Should save watchlist to the repository', () async {
    // arrange
    when(() => repo.save(testItem))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase(testItem);
    // assert
    verify(() => repo.save(testItem));
    expect(result, const Right('Added to Watchlist'));
  });
}
