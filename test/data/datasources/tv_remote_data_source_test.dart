import 'dart:convert';

import 'package:dicoding_ditonton/common/exception.dart';
import 'package:dicoding_ditonton/data/models/tv_response.dart';
import 'package:http/http.dart' as http;

import 'package:dicoding_ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_helper.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvRemoteDataSource dataSource;
  late http.Client mockHttpClient;

  setUp(() {
    mockHttpClient = MockV2HttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group(
    'Get Top Rated TV Shows',
    () {
      final json = readJson('dummy_data/tv_top_rated.json');
      final tvMovieList = TvResponse.fromJson(jsonDecode(json)).results;
      registerFallbackValue(Uri.parse('$baseUrl/movie/top_rated?$apiKey'));

      test(
        'Should return list of movies when response code is 200 ',
        () async {
          when(
            () => mockHttpClient.get(any<Uri>()),
          ).thenAnswer(
            (_) async => get200Json(json),
          );

          // act
          final result = await dataSource.getTopRated();

          // assert
          expect(result, tvMovieList);
        },
      );

      test(
        'Should throw ServerException when response code is other than 200',
        () async {
          // arrange
          when(
            () => mockHttpClient.get(any<Uri>()),
          ).thenAnswer(
            (_) async => http.Response('Not Found', 404),
          );

          // act
          final call = dataSource.getTopRated();

          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
