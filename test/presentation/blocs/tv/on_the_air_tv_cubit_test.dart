import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/enums/show_type.dart';
import 'package:dicoding_ditonton/domain/usecases/tv/get_on_the_air_tv.dart';
import 'package:dicoding_ditonton/presentation/blocs/tv/on_the_air_tv_cubit.dart';

class MockGetOnTheAirTv extends Mock implements GetOnTheAirTv {}

void main() {
  late GetOnTheAirTv mockGetOnTheAirTv;
  late OnTheAirTvCubit bloc;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    bloc = OnTheAirTvCubit(getOnTheAirTv: mockGetOnTheAirTv);
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

  test('Should change state to loading when usecase is called', () async {
    // arrange
    when(() => mockGetOnTheAirTv()).thenAnswer((_) async => Right(tDummyList));
    // act
    bloc.fetch();
    // assert
    expect(bloc.state.state, RequestState.loading);
    expect(listenerCallCount, 0);
  });

  test('Should update tv show data when success result', () async {
    // arrange
    when(() => mockGetOnTheAirTv())
        .thenAnswer((_) async => Right(tDummyList));
    // act
    await bloc.fetch();
    // assert
    expect(bloc.state.state, RequestState.loaded);
    expect(bloc.state.movies, tDummyList);
    expect(listenerCallCount, 1);
  });

  test('Should return error when data response is unsuccessful', () async {
    // arrange
    when(() => mockGetOnTheAirTv())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await bloc.fetch();
    // assert
    expect(bloc.state.state, RequestState.error);
    expect(bloc.state.message, 'Server Failure');
    expect(listenerCallCount, 1);
  });
}