import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:watchlist/domain/repositories/watchlist_repository.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late GetWatchlistItems usecase;
  late WatchlistRepository repo;

  setUp(() {
    repo = MockWatchlistRepository();
    usecase = GetWatchlistItems(repo: repo);
  });

  test('Should get list of watchlist from the repository', () async {
    // arrange
    when(() => repo.getList())
        .thenAnswer((_) async => const Right(testList));
    // act
    final result = await usecase();
    // assert
    expect(result, const Right(testList));
  });
}
