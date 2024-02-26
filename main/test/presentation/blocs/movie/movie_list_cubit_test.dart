import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/enums/show_type.dart';
import 'package:dicoding_ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:dicoding_ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:dicoding_ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:dicoding_ditonton/presentation/blocs/movie/movie_list_cubit.dart';

class MockGetOnTheAirMovie extends Mock implements GetNowPlayingMovies {}
class MockGetPopularMovie extends Mock implements GetPopularMovies {}
class MockGetTopRatedMovie extends Mock implements GetTopRatedMovies {}

void main() {
  late MovieListCubit bloc;
  late GetNowPlayingMovies mockGetNowPlayingMovies;
  late GetPopularMovies mockGetPopularMovies;
  late GetTopRatedMovies mockGetTopRatedMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingMovies = MockGetOnTheAirMovie();
    mockGetPopularMovies = MockGetPopularMovie();
    mockGetTopRatedMovies = MockGetTopRatedMovie();
    bloc = MovieListCubit(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
    bloc.stream.listen((_) {
      listenerCallCount++;
    });
  });

  const tDummy = Movie(
    type: ShowType.movie,
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
    voteAverage: 1,
    voteCount: 1,
  );
  final tDummyList = <Movie>[tDummy];

  group('On The Air Movies', () {
    test('initialState should be Empty', () {
      expect(bloc.state.statePopular, equals(RequestState.empty));
    });

    test('Should get data from the usecase', () async {
      // arrange
      when(() => mockGetNowPlayingMovies())
          .thenAnswer((_) async => Right(tDummyList));
      // act
      bloc.fetchNowPlaying();
      // assert
      verify(() => mockGetNowPlayingMovies());
    });

    test('Should change state to Loading when usecase is called', () {
      // arrange
      when(() => mockGetNowPlayingMovies())
          .thenAnswer((_) async => Right(tDummyList));
      // act
      bloc.fetchNowPlaying();
      // assert
      expect(bloc.state.stateNowPlaying, RequestState.loading);
    });

    test('Should change when data is gotten successfully', () async {
      // arrange
      when(() => mockGetNowPlayingMovies())
          .thenAnswer((_) async => Right(tDummyList));
      // act
      await bloc.fetchNowPlaying();
      // assert
      expect(bloc.state.stateNowPlaying, RequestState.loaded);
      expect(bloc.state.moviesNowPlaying, tDummyList);
      expect(listenerCallCount, 1);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(() => mockGetNowPlayingMovies())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await bloc.fetchNowPlaying();
      // assert
      expect(bloc.state.stateNowPlaying, RequestState.error);
      expect(bloc.state.message, 'Server Failure');
      expect(listenerCallCount, 1);
    });
  });

  group('Popular Movies', () {
    test('Should change state to loading when usecase is called', () async {
      // arrange
      when(() => mockGetPopularMovies())
          .thenAnswer((_) async => Right(tDummyList));
      // act
      bloc.fetchPopular();
      // assert
      expect(bloc.state.statePopular, RequestState.loading);
    });

    test('Should change data when data is gotten successfully',
        () async {
      // arrange
      when(() => mockGetPopularMovies())
          .thenAnswer((_) async => Right(tDummyList));
      // act
      await bloc.fetchPopular();
      // assert
      expect(bloc.state.statePopular, RequestState.loaded);
      expect(bloc.state.moviesPopular, tDummyList);
      expect(listenerCallCount, 1);
    });

    test('Should return error when data is unsuccessful', () async {
      // arrange
      when(() => mockGetPopularMovies())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await bloc.fetchPopular();
      // assert
      expect(bloc.state.statePopular, RequestState.error);
      expect(bloc.state.message, 'Server Failure');
      expect(listenerCallCount, 1);
    });
  });

  group('Top Rated Movies', () {
    test('Should change state to loading when usecase is called', () async {
      // arrange
      when(() => mockGetTopRatedMovies())
          .thenAnswer((_) async => Right(tDummyList));
      // act
      bloc.fetchTopRated();
      // assert
      expect(bloc.state.stateTopRated, RequestState.loading);
    });

    test('Should change data when data is gotten successfully',
        () async {
      // arrange
      when(() => mockGetTopRatedMovies())
          .thenAnswer((_) async => Right(tDummyList));
      // act
      await bloc.fetchTopRated();
      // assert
      expect(bloc.state.stateTopRated, RequestState.loaded);
      expect(bloc.state.moviesTopRated, tDummyList);
      expect(listenerCallCount, 1);
    });

    test('Should return error when data is unsuccessful', () async {
      // arrange
      when(() => mockGetTopRatedMovies())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await bloc.fetchTopRated();
      // assert
      expect(bloc.state.stateTopRated, RequestState.error);
      expect(bloc.state.message, 'Server Failure');
      expect(listenerCallCount, 1);
    });
  });
}
