import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';
import 'package:watchlist/watchlist.dart';

import '../../helpers/test_helper.dart';

void main() {
  late GetWatchListStatus usecase;
  late WatchlistRepository repo;

  setUp(() {
    repo = MockWatchlistRepository();
    usecase = GetWatchListStatus(repo: repo);
  });

  test('Should get watchlist status from repository', () async {
    // arrange
    when(() => repo.isAdded(1)).thenAnswer((_) async => true);
    // act
    final result = await usecase(1);
    // assert
    expect(result, true);
  });
}
