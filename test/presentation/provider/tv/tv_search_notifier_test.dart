import 'package:dicoding_ditonton/domain/enums/show_type.dart';
import 'package:dicoding_ditonton/domain/usecases/tv/search_tv.dart';
import 'package:dicoding_ditonton/presentation/provider/tv/tv_search_notifier.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchTv extends Mock implements SearchTv {}

void main() {
  late TvSearchNotifier provider;
  late SearchTv mockSearchTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTv = MockSearchTv();
    provider = TvSearchNotifier(searchTv: mockSearchTv)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tMovieModel = Movie(
    type: ShowType.tv,
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
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  group('Search TV Shows', () {
    test('Should change state to loading when usecase is called', () async {
      // arrange
      when(() => mockSearchTv(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetch(tQuery);
      // assert
      expect(provider.state, RequestState.loading);
    });

    test('Should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(() => mockSearchTv(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetch(tQuery);
      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.searchResult, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('Should return error when response data is unsuccessful', () async {
      // arrange
      when(() => mockSearchTv(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetch(tQuery);
      // assert
      expect(provider.state, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
