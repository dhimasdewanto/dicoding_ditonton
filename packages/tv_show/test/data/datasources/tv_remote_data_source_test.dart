import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_show/data/datasources/tv_remote_data_source.dart';
import 'package:tv_show/data/models/tv_detail_model.dart';
import 'package:tv_show/data/models/tv_response.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.dart';

void main() {
  late TvRemoteDataSource dataSource;
  late http.Client mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
    registerFallbackValue(FakeUri());
  });

  group(
    'Get On The Air TV Shows',
    () {
      final json = readJson('dummy_data/tv_airing_today.json');
      final tvMovieList = TvResponse.fromMap(jsonDecode(json)).results;

      test(
        'Should return list when response code is 200 ',
        () async {
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => get200Json(json),
          );

          // act
          final result = await dataSource.getOnTheAir();

          // assert
          expect(result, tvMovieList);
        },
      );

      test(
        'Should throw ServerException when response code is other than 200',
        () async {
          // arrange
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => http.Response('Not Found', 404),
          );

          // act
          final call = dataSource.getOnTheAir();

          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    'Get Popular TV Shows',
    () {
      final json = readJson('dummy_data/tv_popular.json');
      final tvMovieList = TvResponse.fromMap(jsonDecode(json)).results;

      test(
        'Should return list when response code is 200 ',
        () async {
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => get200Json(json),
          );

          // act
          final result = await dataSource.getPopular();

          // assert
          expect(result, tvMovieList);
        },
      );

      test(
        'Should throw ServerException when response code is other than 200',
        () async {
          // arrange
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => http.Response('Not Found', 404),
          );

          // act
          final call = dataSource.getPopular();

          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    'Get Top Rated TV Shows',
    () {
      final json = readJson('dummy_data/tv_top_rated.json');
      final tvMovieList = TvResponse.fromMap(jsonDecode(json)).results;

      test(
        'Should return list when response code is 200 ',
        () async {
          when(
            () => mockHttpClient.get(any()),
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
            () => mockHttpClient.get(any()),
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

  group(
    'Get Recomendation based on ID of TV Show',
    () {
      const id = 59941;
      final json = readJson('dummy_data/tv_recommendations_id_$id.json');
      final tvMovieList = TvResponse.fromMap(jsonDecode(json)).results;

      test(
        'Should return list when response code is 200 ',
        () async {
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => get200Json(json),
          );

          // act
          final result = await dataSource.getRecommendations(id);

          // assert
          expect(result, tvMovieList);
        },
      );

      test(
        'Should throw ServerException when response code is other than 200',
        () async {
          // arrange
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => http.Response('Not Found', 404),
          );

          // act
          final call = dataSource.getRecommendations(id);

          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    'Search TV Show',
    () {
      const query = "witcher";
      final json = readJson('dummy_data/tv_search_$query.json');
      final tvMovieList = TvResponse.fromMap(jsonDecode(json)).results;

      test(
        'Should return list when response code is 200 ',
        () async {
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => get200Json(json),
          );

          // act
          final result = await dataSource.search(query);

          // assert
          expect(result, tvMovieList);
        },
      );

      test(
        'Should throw ServerException when response code is other than 200',
        () async {
          // arrange
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => http.Response('Not Found', 404),
          );

          // act
          final call = dataSource.search(query);

          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    'Get TV Show Detail Based On ID',
    () {
      const id = 71912;
      final json = readJson('dummy_data/tv_detail_id_$id.json');

      test(
        'Should return list when response code is 200 ',
        () async {
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => get200Json(json),
          );

          // act
          final result = await dataSource.getDetail(id);

          // assert
          final tvDetail = TvDetailModel.fromMap(jsonDecode(json));
          expect(result, tvDetail);
        },
      );

      test(
        'Should throw ServerException when response code is other than 200',
        () async {
          // arrange
          when(
            () => mockHttpClient.get(any()),
          ).thenAnswer(
            (_) async => http.Response('Not Found', 404),
          );

          // act
          final call = dataSource.getDetail(id);

          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
