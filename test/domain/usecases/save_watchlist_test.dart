import 'package:dicoding_ditonton/domain/repositories/watchlist_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dicoding_ditonton/domain/usecases/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late SaveWatchlist usecase;
  late WatchlistRepository repo;

  setUp(() {
    repo = MockWatchlistRepository();
    usecase = SaveWatchlist(repo);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(() => repo.saveDetail(testMovieDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase(testMovieDetail);
    // assert
    verify(() => repo.saveDetail(testMovieDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
