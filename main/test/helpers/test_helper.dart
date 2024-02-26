import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:dicoding_ditonton/data/datasources/db/database_helper.dart';
import 'package:dicoding_ditonton/data/datasources/movie_local_data_source.dart';
import 'package:dicoding_ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:dicoding_ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:dicoding_ditonton/domain/repositories/movie_repository.dart';
import 'package:dicoding_ditonton/domain/repositories/tv_repository.dart';
import 'package:dicoding_ditonton/domain/repositories/watchlist_repository.dart';

/// Using mocktail.
class MockMovieRepository extends Mock implements MovieRepository {}

class MockMovieRemoteDataSource extends Mock
    implements MovieRemoteDataSource {}

class MockMovieLocalDataSource extends Mock implements MovieLocalDataSource {}

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

class MockHttpClient extends Mock implements http.Client {}

class MockTvRemoteDataSource extends Mock implements TvRemoteDataSource {}

class MockTvRepository extends Mock implements TvRepository {}

class MockWatchlistRepository extends Mock implements WatchlistRepository {}

class FakeUri extends Fake implements Uri {}

/// Get 200 response from json body.
http.Response get200Json(String json) {
  return http.Response(
    json,
    200,
    headers: {
      'content-type': 'application/json; charset=utf-8',
    },
  );
}
