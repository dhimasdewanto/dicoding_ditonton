import 'package:dicoding_ditonton/domain/repositories/watchlist_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dicoding_ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late RemoveWatchlist usecase;
  late WatchlistRepository repo;

  setUp(() {
    repo = MockWatchlistRepository();
    usecase = RemoveWatchlist(repo);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(() => repo.removeDetail(testMovieDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase(testMovieDetail);
    // assert
    verify(() => repo.removeDetail(testMovieDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
