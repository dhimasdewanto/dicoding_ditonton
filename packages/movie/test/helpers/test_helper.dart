import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

/// Using mocktail.
class MockMovieRepository extends Mock implements MovieRepository {}

class MockMovieRemoteDataSource extends Mock
    implements MovieRemoteDataSource {}

class MockHttpClient extends Mock implements http.Client {}

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
