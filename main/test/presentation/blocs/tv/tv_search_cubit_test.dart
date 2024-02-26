import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:core/core.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/enums/show_type.dart';
import 'package:dicoding_ditonton/domain/usecases/tv/search_tv.dart';
import 'package:dicoding_ditonton/presentation/blocs/tv/tv_search_cubit.dart';

class MockSearchTv extends Mock implements SearchTv {}

void main() {
  late TvSearchCubit bloc;
  late SearchTv mockSearchTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTv = MockSearchTv();
    bloc = TvSearchCubit(searchTv: mockSearchTv);
    bloc.stream.listen((_) {
      listenerCallCount++;
    });
  });

  const tDummy = Movie(
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
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tDummyList = <Movie>[tDummy];
  const tQuery = 'spiderman';

  group('Search TV Shows', () {
    test('Should change state to loading when usecase is called', () async {
      // arrange
      when(() => mockSearchTv(tQuery))
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
      when(() => mockSearchTv(tQuery))
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
      when(() => mockSearchTv(tQuery))
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
