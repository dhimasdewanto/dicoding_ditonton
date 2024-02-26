import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:core/core.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/enums/show_type.dart';
import 'package:dicoding_ditonton/domain/usecases/tv/get_on_the_air_tv.dart';
import 'package:dicoding_ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:dicoding_ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:dicoding_ditonton/presentation/blocs/tv/tv_list_cubit.dart';

class MockGetOnTheAirTv extends Mock implements GetOnTheAirTv {}
class MockGetPopularTv extends Mock implements GetPopularTv {}
class MockGetTopRatedTv extends Mock implements GetTopRatedTv {}

void main() {
  late TvListCubit bloc;
  late GetOnTheAirTv mockGetOnTheAirTv;
  late GetPopularTv mockGetPopularTv;
  late GetTopRatedTv mockGetTopRatedTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    bloc = TvListCubit(
      getOnTheAirTv: mockGetOnTheAirTv,
      getPopularTv: mockGetPopularTv,
      getTopRatedTv: mockGetTopRatedTv,
    );
    bloc.stream.listen((_) {
      listenerCallCount++;
    });
  });

  const tDummy = Movie(
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
    voteAverage: 1,
    voteCount: 1,
  );
  final tDummyList = <Movie>[tDummy];

  group('On The Air TV Shows', () {
    test('initialState should be Empty', () {
      expect(bloc.state.stateOnTheAir, equals(RequestState.empty));
    });

    test('Should get data from the usecase', () async {
      // arrange
      when(() => mockGetOnTheAirTv())
          .thenAnswer((_) async => Right(tDummyList));
      // act
      bloc.fetchOnTheAir();
      // assert
      verify(() => mockGetOnTheAirTv());
    });

    test('Should change state to Loading when usecase is called', () {
      // arrange
      when(() => mockGetOnTheAirTv())
          .thenAnswer((_) async => Right(tDummyList));
      // act
      bloc.fetchOnTheAir();
      // assert
      expect(bloc.state.stateOnTheAir, RequestState.loading);
    });

    test('Should change when data is gotten successfully', () async {
      // arrange
      when(() => mockGetOnTheAirTv())
          .thenAnswer((_) async => Right(tDummyList));
      // act
      await bloc.fetchOnTheAir();
      // assert
      expect(bloc.state.stateOnTheAir, RequestState.loaded);
      expect(bloc.state.moviesOnTheAir, tDummyList);
      expect(listenerCallCount, 1);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(() => mockGetOnTheAirTv())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await bloc.fetchOnTheAir();
      // assert
      expect(bloc.state.stateOnTheAir, RequestState.error);
      expect(bloc.state.message, 'Server Failure');
      expect(listenerCallCount, 1);
    });
  });

  group('Popular TV Shows', () {
    test('Should change state to loading when usecase is called', () async {
      // arrange
      when(() => mockGetPopularTv())
          .thenAnswer((_) async => Right(tDummyList));
      // act
      bloc.fetchPopular();
      // assert
      expect(bloc.state.statePopular, RequestState.loading);
    });

    test('Should change data when data is gotten successfully',
        () async {
      // arrange
      when(() => mockGetPopularTv())
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
      when(() => mockGetPopularTv())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await bloc.fetchPopular();
      // assert
      expect(bloc.state.statePopular, RequestState.error);
      expect(bloc.state.message, 'Server Failure');
      expect(listenerCallCount, 1);
    });
  });

  group('Top Rated TV Shows', () {
    test('Should change state to loading when usecase is called', () async {
      // arrange
      when(() => mockGetTopRatedTv())
          .thenAnswer((_) async => Right(tDummyList));
      // act
      bloc.fetchTopRated();
      // assert
      expect(bloc.state.stateTopRated, RequestState.loading);
    });

    test('Should change data when data is gotten successfully',
        () async {
      // arrange
      when(() => mockGetTopRatedTv())
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
      when(() => mockGetTopRatedTv())
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
