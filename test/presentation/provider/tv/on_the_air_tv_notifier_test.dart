import 'package:dicoding_ditonton/domain/enums/show_type.dart';
import 'package:dicoding_ditonton/domain/usecases/tv/get_on_the_air_tv.dart';
import 'package:dicoding_ditonton/presentation/provider/tv/on_the_air_tv_notifier.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetOnTheAirTv extends Mock implements GetOnTheAirTv {}

void main() {
  late GetOnTheAirTv mockGetOnTheAirTv;
  late OnTheAirTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    notifier = OnTheAirTvNotifier(getOnTheAirTv: mockGetOnTheAirTv)
      ..addListener(() {
        listenerCallCount++;
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
    
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test('Should change state to loading when usecase is called', () async {
    // arrange
    when(() => mockGetOnTheAirTv())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    notifier.fetch();
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('Should update tv show data when success result', () async {
    // arrange
    when(() => mockGetOnTheAirTv())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    await notifier.fetch();
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.movies, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('Should return error when data response is unsuccessful', () async {
    // arrange
    when(() => mockGetOnTheAirTv())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetch();
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
