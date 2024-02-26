import 'package:dicoding_ditonton/domain/repositories/watchlist_repository.dart';
import 'package:dicoding_ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/test_helper.dart';

void main() {
  late GetWatchListStatus usecase;
  late WatchlistRepository repo;

  setUp(() {
    repo = MockWatchlistRepository();
    usecase = GetWatchListStatus(repo);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(() => repo.isAdded(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase(1);
    // assert
    expect(result, true);
  });
}
