import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tv_show/data/datasources/tv_remote_data_source.dart';
import 'package:tv_show/data/models/genre_model.dart';
import 'package:tv_show/data/models/season_model.dart';
import 'package:tv_show/data/models/tv_detail_model.dart';
import 'package:tv_show/data/models/tv_model.dart';
import 'package:tv_show/data/repositories/tv_repository_impl.dart';
import 'package:tv_show/domain/entities/genre.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/entities/season.dart';
import 'package:tv_show/domain/entities/tv_show_detail.dart';
import 'package:tv_show/domain/repositories/tv_repository.dart';

import '../../helpers/test_helper.dart';

void main() {
  late TvRepository repository;
  late TvRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  const tModel = TvModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  const tItem = TvShow(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tModelList = <TvModel>[tModel];
  final tList = <TvShow>[tItem];

  group('TV Shows On The Air', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getOnTheAir())
          .thenAnswer((_) async => tModelList);
      // act
      final result = await repository.getOnTheAir();
      // assert
      verify(() => mockRemoteDataSource.getOnTheAir());

      final resultList = result.getOrElse((_) => []);
      expect(resultList.firstOrNull?.id, tList.firstOrNull?.id);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getOnTheAir())
          .thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAir();
      // assert
      verify(() => mockRemoteDataSource.getOnTheAir());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getOnTheAir())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnTheAir();
      // assert
      verify(() => mockRemoteDataSource.getOnTheAir());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TV Shows', () {
    test('should return movie list when call to data source is success',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getPopular())
          .thenAnswer((_) async => tModelList);
      // act
      final result = await repository.getPopular();

      final resultList = result.getOrElse((_) => []);
      expect(resultList.firstOrNull?.id, tList.firstOrNull?.id);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getPopular())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopular();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getPopular())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopular();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TV Shows', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getTopRated())
          .thenAnswer((_) async => tModelList);
      // act
      final result = await repository.getTopRated();
      // assert

      final resultList = result.getOrElse((_) => []);
      expect(resultList.firstOrNull?.id, tList.firstOrNull?.id);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getTopRated())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRated();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getTopRated())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRated();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Detail of TV Show', () {
    const tId = 557;
    final tTvResponse = TvDetailModel(
      type: '',
      adult: false,
      backdropPath: 'backdropPath',
      genres: const [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: tId,
      originalLanguage: 'en',
      originalName: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      status: 'Status',
      tagline: 'Tagline',
      voteAverage: 1,
      voteCount: 1,
      episodeRunTime: const [],
      firstAirDate: DateTime(2000),
      inProduction: false,
      languages: const [],
      lastAirDate: DateTime(2000),
      name: '',
      nextEpisodeToAir: null,
      numberOfEpisodes: 3,
      numberOfSeasons: 3,
      originCountry: const [],
      seasons: [
        SeasonModel(
          airDate: DateTime(1990),
          episodeCount: 5,
          id: 123,
          name: "Season 1",
          overview: "",
          posterPath: "",
          seasonNumber: 1,
          voteAverage: 5,
        ),
      ],
    );
    final tTvDetail = TvShowDetail(
      adult: false,
      backdropPath: 'backdropPath',
      genres: const [Genre(id: 1, name: 'Action')],
      id: tId,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1,
      title: '',
      releaseDate: "2000-01-01 00:00:00.000",
      runtime: 3,
      seasons: [
        Season(
          airDate: DateTime(1990),
          episodeCount: 5,
          id: 123,
          name: "Season 1",
          overview: "",
          posterPath: "",
          seasonNumber: 1,
          voteAverage: 5,
        ),
      ],
    );

    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getDetail(tId))
          .thenAnswer((_) async => tTvResponse);
      // act
      final result = await repository.getDetail(tId);
      // assert
      verify(() => mockRemoteDataSource.getDetail(tId));

      final res = result.map((res) => res).fold((l) => null, (r) => r);
      final seasons =
          result.map((res) => res.seasons).fold((l) => <Season>[], (r) => r);
      expect(res, tTvDetail);
      expect(seasons.firstOrNull, tTvDetail.seasons.firstOrNull);
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getDetail(tId);
      // assert
      verify(() => mockRemoteDataSource.getDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getDetail(tId);
      // assert
      verify(() => mockRemoteDataSource.getDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV Recommendations', () {
    // final tMovieList = <TvModel>[];
    const tId = 1;

    test('should return data (tv list) when the call is successful', () async {
      // arrange
      when(() => mockRemoteDataSource.getRecommendations(tId))
          .thenAnswer((_) async => tModelList);
      // act
      final result = await repository.getRecommendations(tId);
      // assert
      verify(() => mockRemoteDataSource.getRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse((_) => []);
      expect(resultList, equals(tList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getRecommendations(tId);
      // assertbuild runner
      verify(() => mockRemoteDataSource.getRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getRecommendations(tId);
      // assert
      verify(() => mockRemoteDataSource.getRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Movies', () {
    const tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.search(tQuery))
          .thenAnswer((_) async => tModelList);
      // act
      final result = await repository.search(tQuery);
      // assert

      final resultList = result.getOrElse((_) => []);
      expect(resultList.firstOrNull?.id, tList.firstOrNull?.id);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.search(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.search(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(() => mockRemoteDataSource.search(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.search(tQuery);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });
}
