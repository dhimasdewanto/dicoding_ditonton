import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/data/datasources/watchlist_local_data_source.dart';
import 'package:watchlist/data/repositories/watchlist_repository_impl.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistLocalDataSource extends Mock implements WatchlistLocalDataSource {}

void main() {
  late WatchlistRepository repository;
  late WatchlistLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockWatchlistLocalDataSource();
    repository = WatchlistRepositoryImpl(
      localDataSource: mockLocalDataSource,
    );
  });

  group('Save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(() => mockLocalDataSource.insertWatchlist(testTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.save(testItem);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(() => mockLocalDataSource.insertWatchlist(testTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.save(testItem);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(() => mockLocalDataSource.removeWatchlist(testTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.remove(testItem);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(() => mockLocalDataSource.removeWatchlist(testTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.remove(testItem);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(() => mockLocalDataSource.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAdded(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(() => mockLocalDataSource.getWatchlistMovies())
          .thenAnswer((_) async => [testTable]);
      // act
      final result = await repository.getList();
      // assert
      final resultList = result.getOrElse((_) => []);
      expect(resultList, [testItem]);
    });
  });
}