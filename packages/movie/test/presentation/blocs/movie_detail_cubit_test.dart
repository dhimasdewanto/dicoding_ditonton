import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/blocs/movie_detail_cubit.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetMovieDetail extends Mock implements GetMovieDetail {}
class MockGetMovieRecommendations extends Mock implements GetMovieRecommendations {}
// class MockGetWatchListStatus extends Mock implements GetWatchListStatus {}
// class MockSaveWatchlist extends Mock implements SaveWatchlist {}
// class MockRemoveWatchlist extends Mock implements RemoveWatchlist {}

void main() {
  late MovieDetailCubit bloc;
  late GetMovieDetail mockGetMovieDetail;
  late GetMovieRecommendations mockGetMovieRecommendations;
  // late GetWatchListStatus mockGetWatchlistStatus;
  // late SaveWatchlist mockSaveWatchlist;
  // late RemoveWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    // mockGetWatchlistStatus = MockGetWatchListStatus();
    // mockSaveWatchlist = MockSaveWatchlist();
    // mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = MovieDetailCubit(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      // getWatchListStatus: mockGetWatchlistStatus,
      // saveWatchlist: mockSaveWatchlist,
      // removeWatchlist: mockRemoveWatchlist,
    );
    bloc.stream.listen((_) {
      listenerCallCount++;
    });
  });

  const tId = 1;
  const tDummy = Movie(
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

  void arrangeUsecase() {
    when(() => mockGetMovieDetail(tId))
        .thenAnswer((_) async => const Right(testMovieDetail));
    when(() => mockGetMovieRecommendations(tId))
        .thenAnswer((_) async => Right(tDummyList));
  }

  group('Get Movie Show Detail', () {
    test('Should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await bloc.fetch(tId);
      // assert
      verify(() => mockGetMovieDetail(tId));
      verify(() => mockGetMovieRecommendations(tId));
    });

    test('Should change state to Loading when usecase is called', () {
      // arrange
      arrangeUsecase();
      // act
      bloc.fetch(tId);
      // assert
      expect(bloc.state.movieState, RequestState.loading);
      expect(listenerCallCount, 0);
    });

    test('Should change when data is gotten successfully', () async {
      // arrange
      arrangeUsecase();
      // act
      await bloc.fetch(tId);
      // assert
      expect(bloc.state.movieState, RequestState.loaded);
      expect(bloc.state.movie, testMovieDetail);
      expect(listenerCallCount, 2);
    });

    test('Should change recommendation when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await bloc.fetch(tId);
      // assert
      expect(bloc.state.movieState, RequestState.loaded);
      expect(bloc.state.recommendations, tDummyList);
    });
  });

  group('Get Recommendations Based On Current Movie', () {
    test('Should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await bloc.fetch(tId);
      // assert
      verify(() => mockGetMovieRecommendations(tId));
      expect(bloc.state.recommendations, tDummyList);
    });

    test('Should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await bloc.fetch(tId);
      // assert
      expect(bloc.state.recommendationState, RequestState.loaded);
      expect(bloc.state.recommendations, tDummyList);
    });

    test('Should update error message when request in successful', () async {
      // arrange
      when(() => mockGetMovieDetail(tId))
          .thenAnswer((_) async => const Right(testMovieDetail));
      when(() => mockGetMovieRecommendations(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await bloc.fetch(tId);
      // assert
      expect(bloc.state.recommendationState, RequestState.error);
      expect(bloc.state.message, 'Failed');
    });
  });

  // group('Watchlist', () {
  //   test('Should get the watchlist status', () async {
  //     // arrange
  //     when(() => mockGetWatchlistStatus(1)).thenAnswer((_) async => true);
  //     // act
  //     await bloc.loadWatchlistStatus(1);
  //     // assert
  //     expect(bloc.state.isAddedToWatchlist, true);
  //   });

  //   test('Should execute save watchlist when function called', () async {
  //     // arrange
  //     const itemDetail = testMovieDetail;
  //     final item = itemDetail.toMovie();
  //     when(() => mockSaveWatchlist(item))
  //         .thenAnswer((_) async => const Right('Success'));
  //     when(() => mockGetWatchlistStatus(itemDetail.id))
  //         .thenAnswer((_) async => true);
  //     // act
  //     await bloc.addWatchlist(itemDetail);
  //     // assert
  //     verify(() => mockSaveWatchlist(item));
  //   });

  //   test('Should execute remove watchlist when function called', () async {
  //     // arrange
  //     const itemDetail = testMovieDetail;
  //     final item = itemDetail.toMovie();
  //     when(() => mockRemoveWatchlist(item))
  //         .thenAnswer((_) async => const Right('Removed'));
  //     when(() => mockGetWatchlistStatus(itemDetail.id))
  //         .thenAnswer((_) async => false);
  //     // act
  //     await bloc.removeFromWatchlist(itemDetail);
  //     // assert
  //     verify(() => mockRemoveWatchlist(item));
  //   });

  //   test('Should update watchlist status when add watchlist success', () async {
  //     // arrange
  //     const itemDetail = testMovieDetail;
  //     final item = itemDetail.toMovie();
  //     when(() => mockSaveWatchlist(item))
  //         .thenAnswer((_) async => const Right('Added to Watchlist'));
  //     when(() => mockGetWatchlistStatus(itemDetail.id))
  //         .thenAnswer((_) async => true);
  //     // act
  //     await bloc.addWatchlist(itemDetail);
  //     // assert
  //     verify(() => mockGetWatchlistStatus(itemDetail.id));
  //     expect(bloc.state.isAddedToWatchlist, true);
  //     expect(bloc.state.watchlistMessage, 'Added to Watchlist');
  //     expect(listenerCallCount, 1);
  //   });

  //   test('Should update watchlist message when add watchlist failed', () async {
  //     // arrange
  //     const itemDetail = testMovieDetail;
  //     final item = itemDetail.toMovie();
  //     when(() => mockSaveWatchlist(item))
  //         .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
  //     when(() => mockGetWatchlistStatus(itemDetail.id))
  //         .thenAnswer((_) async => false);
  //     // act
  //     await bloc.addWatchlist(itemDetail);
  //     // assert
  //     expect(bloc.state.watchlistMessage, 'Failed');
  //     expect(listenerCallCount, 1);
  //   });
  // });

  group('When Error Occur', () {
    test('Should return error when data is unsuccessful', () async {
      // arrange
      when(() => mockGetMovieDetail(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(() => mockGetMovieRecommendations(tId))
          .thenAnswer((_) async => Right(tDummyList));
      // act
      await bloc.fetch(tId);
      // assert
      expect(bloc.state.movieState, RequestState.error);
      expect(bloc.state.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
