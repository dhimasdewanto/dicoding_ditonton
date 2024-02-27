import 'package:flutter_test/flutter_test.dart';
import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:watchlist/watchlist.dart';

void main() {
  group('Movie', () {
    test('Should success convert fromEntity', () {
      final result = WatchlistTable.fromEntity(testItemMovie);
      expect(result, testTableMovie);
    });

    test('Should success convert fromMap', () {
      final result = WatchlistTable.fromMap(testMapMovie);
      expect(result, testTableMovie);
    });

    test('Should success convert toEntity', () {
      final result = testTableMovie.toEntity();
      expect(result, testItemMovie);
    });

    test('Should success convert toMap', () {
      final result = testTableMovie.toMap();
      expect(result, testMapMovie);
    });
  });

  group('TV Show', () {
    test('Should success convert fromEntity', () {
      final result = WatchlistTable.fromEntity(testItemTv);
      expect(result, testTableTv);
    });

    test('Should success convert fromMap', () {
      final result = WatchlistTable.fromMap(testMapTv);
      expect(result, testTableTv);
    });

    test('Should success convert toEntity', () {
      final result = testTableTv.toEntity();
      expect(result, testItemTv);
    });

    test('Should success convert toMap', () {
      final result = testTableTv.toMap();
      expect(result, testMapTv);
    });
  });
}

const testTableMovie = WatchlistTable(
  type: "movie",
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMapMovie = {
  'id': 1,
  'type': 'movie',
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

const testItemMovie = Watchlist(
  type: ShowType.movie,
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  title: 'title',
);

const testTableTv = WatchlistTable(
  type: "tv",
  id: 2,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMapTv = {
  'id': 2,
  'type': 'tv',
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

const testItemTv = Watchlist(
  type: ShowType.tv,
  id: 2,
  overview: 'overview',
  posterPath: 'posterPath',
  title: 'title',
);