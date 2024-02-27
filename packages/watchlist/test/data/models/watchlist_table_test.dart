import 'package:flutter_test/flutter_test.dart';
import 'package:watchlist/data/models/watchlist_table.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('Should success convert fromEntity', () {
    final result = WatchlistTable.fromEntity(testItem);
    expect(result, testTable);
  });

  test('Should success convert fromMap', () {
    final result = WatchlistTable.fromMap(testMap);
    expect(result, testTable);
  });

  test('Should success convert toEntity', () {
    final result = testTable.toEntity();
    expect(result, testItem);
  });

  test('Should success convert toMap', () {
    final result = testTable.toMap();
    expect(result, testMap);
  });
}