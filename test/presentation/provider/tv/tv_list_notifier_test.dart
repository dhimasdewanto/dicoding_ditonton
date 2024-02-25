import 'package:dicoding_ditonton/domain/enums/show_type.dart';
import 'package:dicoding_ditonton/domain/usecases/tv/get_on_the_air_tv.dart';
import 'package:dicoding_ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:dicoding_ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:dicoding_ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetOnTheAirTv extends Mock implements GetOnTheAirTv {}
class MockGetPopularTv extends Mock implements GetPopularTv {}
class MockGetTopRatedTv extends Mock implements GetTopRatedTv {}

void main() {
  late TvListNotifier provider;
  late GetOnTheAirTv mockGetOnTheAirTv;
  late GetPopularTv mockGetPopularTv;
  late GetTopRatedTv mockGetTopRatedTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    provider = TvListNotifier(
      getOnTheAirTv: mockGetOnTheAirTv,
      getPopularTv: mockGetPopularTv,
      getTopRatedTv: mockGetTopRatedTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tMovie = Movie(
    type: ShowType.tv,
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  group('On The Air TV Shows', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirState, equals(RequestState.empty));
    });

    test('Should get data from the usecase', () async {
      // arrange
      when(() => mockGetOnTheAirTv())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchOnTheAir();
      // assert
      verify(() => mockGetOnTheAirTv());
    });

    test('Should change state to Loading when usecase is called', () {
      // arrange
      when(() => mockGetOnTheAirTv())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchOnTheAir();
      // assert
      expect(provider.onTheAirState, RequestState.loading);
    });

    test('Should change when data is gotten successfully', () async {
      // arrange
      when(() => mockGetOnTheAirTv())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchOnTheAir();
      // assert
      expect(provider.onTheAirState, RequestState.loaded);
      expect(provider.onTheAirShows, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(() => mockGetOnTheAirTv())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAir();
      // assert
      expect(provider.onTheAirState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Popular TV Shows', () {
    test('Should change state to loading when usecase is called', () async {
      // arrange
      when(() => mockGetPopularTv())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchPopular();
      // assert
      expect(provider.popularState, RequestState.loading);
    });

    test('Should change data when data is gotten successfully',
        () async {
      // arrange
      when(() => mockGetPopularTv())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchPopular();
      // assert
      expect(provider.popularState, RequestState.loaded);
      expect(provider.popularShows, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('Should return error when data is unsuccessful', () async {
      // arrange
      when(() => mockGetPopularTv())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopular();
      // assert
      expect(provider.popularState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Top Rated TV Shows', () {
    test('Should change state to loading when usecase is called', () async {
      // arrange
      when(() => mockGetTopRatedTv())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchTopRated();
      // assert
      expect(provider.topRatedState, RequestState.loading);
    });

    test('Should change data when data is gotten successfully',
        () async {
      // arrange
      when(() => mockGetTopRatedTv())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchTopRated();
      // assert
      expect(provider.topRatedState, RequestState.loaded);
      expect(provider.topRatedShows, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('Should return error when data is unsuccessful', () async {
      // arrange
      when(() => mockGetTopRatedTv())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRated();
      // assert
      expect(provider.topRatedState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
