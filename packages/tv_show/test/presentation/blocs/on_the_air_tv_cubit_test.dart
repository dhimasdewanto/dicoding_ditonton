import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:core/core.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/usecases/get_on_the_air_tv.dart';
import 'package:tv_show/presentation/blocs/on_the_air_tv_cubit.dart';

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

  const tDummy = TvShow(
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
  final tDummyList = <TvShow>[tDummy];

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
    expect(bloc.state.shows, tDummyList);
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
