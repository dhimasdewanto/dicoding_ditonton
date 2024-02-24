import 'package:dicoding_ditonton/domain/repositories/watchlist_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dicoding_ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late GetWatchlistMovies usecase;
  late WatchlistRepository repo;

  setUp(() {
    repo = MockWatchlistRepository();
    usecase = GetWatchlistMovies(repo);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(() => repo.getList())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase();
    // assert
    expect(result, Right(testMovieList));
  });
}
