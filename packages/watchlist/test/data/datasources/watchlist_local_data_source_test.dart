import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:watchlist/data/datasources/db/database_helper.dart';
import 'package:watchlist/data/datasources/watchlist_local_data_source.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  late WatchlistLocalDataSource dataSource;
  late DatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = WatchlistLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(() => mockDatabaseHelper.insertWatchlist(testTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(() => mockDatabaseHelper.insertWatchlist(testTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(() => mockDatabaseHelper.removeWatchlist(testTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(() => mockDatabaseHelper.removeWatchlist(testTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    const tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(() => mockDatabaseHelper.getMovieById(tId))
          .thenAnswer((_) async => testMap);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, testTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(() => mockDatabaseHelper.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(() => mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMap]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [testTable]);
    });
  });
}
