import 'package:dicoding_ditonton/domain/repositories/watchlist_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dicoding_ditonton/domain/usecases/watchlist/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late RemoveWatchlist usecase;
  late WatchlistRepository repo;

  setUp(() {
    repo = MockWatchlistRepository();
    usecase = RemoveWatchlist(repo: repo);
  });

  test('Should remove watchlist item from repository', () async {
    // arrange
    when(() => repo.remove(testMovie2))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase(testMovie2);
    // assert
    verify(() => repo.remove(testMovie2));
    expect(result, const Right('Removed from watchlist'));
  });
}
