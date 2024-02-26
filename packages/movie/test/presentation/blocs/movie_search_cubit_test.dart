import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:core/core.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/blocs/movie_search_cubit.dart';

class MockSearchMovies extends Mock implements SearchMovies {}

void main() {
  late MovieSearchCubit bloc;
  late SearchMovies mockSearchMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchMovies = MockSearchMovies();
    bloc = MovieSearchCubit(searchMovies: mockSearchMovies);
    bloc.stream.listen((_) {
      listenerCallCount++;
    });
  });

  const tDummy = Movie(
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
  final tDummyList = <Movie>[tDummy];
  const tQuery = 'spiderman';

  group('Search Movies', () {
    test('Should change state to loading when usecase is called', () async {
      // arrange
      when(() => mockSearchMovies(tQuery))
          .thenAnswer((_) async => Right(tDummyList));
      // act
      bloc.fetch(tQuery);
      // assert
      expect(bloc.state.state, RequestState.loading);
      expect(listenerCallCount, 0);
    });

    test('Should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(() => mockSearchMovies(tQuery))
          .thenAnswer((_) async => Right(tDummyList));
      // act
      await bloc.fetch(tQuery);
      // assert
      expect(bloc.state.state, RequestState.loaded);
      expect(bloc.state.searchResults, tDummyList);
      expect(listenerCallCount, 1);
    });

    test('Should return error when response data is unsuccessful', () async {
      // arrange
      when(() => mockSearchMovies(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await bloc.fetch(tQuery);
      // assert
      expect(bloc.state.state, RequestState.error);
      expect(bloc.state.message, 'Server Failure');
      expect(listenerCallCount, 1);
    });
  });
}
