import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:dicoding_ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:dicoding_ditonton/domain/repositories/tv_repository.dart';

/// Using mocktail.

class MockHttpClient extends Mock implements http.Client {}

class MockTvRemoteDataSource extends Mock implements TvRemoteDataSource {}

class MockTvRepository extends Mock implements TvRepository {}

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
