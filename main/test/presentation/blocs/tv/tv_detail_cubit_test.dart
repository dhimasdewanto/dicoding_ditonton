// import 'package:flutter_test/flutter_test.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:mocktail/mocktail.dart';

// import 'package:core/core.dart';
// import 'package:dicoding_ditonton/domain/entities/movie.dart';
// import 'package:dicoding_ditonton/domain/enums/show_type.dart';
// import 'package:dicoding_ditonton/domain/usecases/tv/get_tv_detail.dart';
// import 'package:dicoding_ditonton/domain/usecases/tv/get_tv_recommendations.dart';
// import 'package:dicoding_ditonton/presentation/blocs/tv/tv_detail_cubit.dart';
// import 'package:watchlist/watchlist.dart' as wa;

// import '../../../dummy_data/dummy_objects.dart';

// class MockGetTvDetail extends Mock implements GetTvDetail {}
// class MockGetTvRecommendations extends Mock implements GetTvRecommendations {}
// class MockGetWatchListStatus extends Mock implements wa.GetWatchListStatus {}
// class MockSaveWatchlist extends Mock implements wa.SaveWatchlist {}
// class MockRemoveWatchlist extends Mock implements wa.RemoveWatchlist {}

// void main() {
//   late TvDetailCubit bloc;
//   late GetTvDetail mockGetTvDetail;
//   late GetTvRecommendations mockGetTvRecommendations;
//   late wa.GetWatchListStatus mockGetWatchlistStatus;
//   late wa.SaveWatchlist mockSaveWatchlist;
//   late wa.RemoveWatchlist mockRemoveWatchlist;
//   late int listenerCallCount;

//   setUp(() {
//     listenerCallCount = 0;
//     mockGetTvDetail = MockGetTvDetail();
//     mockGetTvRecommendations = MockGetTvRecommendations();
//     mockGetWatchlistStatus = MockGetWatchListStatus();
//     mockSaveWatchlist = MockSaveWatchlist();
//     mockRemoveWatchlist = MockRemoveWatchlist();
//     bloc = TvDetailCubit(
//       getTvDetail: mockGetTvDetail,
//       getTvRecommendations: mockGetTvRecommendations,
//       getWatchListStatus: mockGetWatchlistStatus,
//       saveWatchlist: mockSaveWatchlist,
//       removeWatchlist: mockRemoveWatchlist,
//     );
//     bloc.stream.listen((_) {
//       listenerCallCount++;
//     });
//   });

//   const tId = 1;
//   const tDummy = Movie(
//     type: ShowType.tv,
//     adult: false,
//     backdropPath: 'backdropPath',
//     genreIds: [1, 2, 3],
//     id: 1,
//     originalTitle: 'originalTitle',
//     overview: 'overview',
//     popularity: 1,
//     posterPath: 'posterPath',
//     releaseDate: 'releaseDate',
//     title: 'title',
//     voteAverage: 1,
//     voteCount: 1,
//   );
//   final tDummyList = <Movie>[tDummy];

//   void arrangeUsecase() {
//     when(() => mockGetTvDetail(tId))
//         .thenAnswer((_) async => const Right(testMovieDetail));
//     when(() => mockGetTvRecommendations(tId))
//         .thenAnswer((_) async => Right(tDummyList));
//   }

//   group('Get TV Show Detail', () {
//     test('Should get data from the usecase', () async {
//       // arrange
//       arrangeUsecase();
//       // act
//       await bloc.fetch(tId);
//       // assert
//       verify(() => mockGetTvDetail(tId));
//       verify(() => mockGetTvRecommendations(tId));
//     });

//     test('Should change state to Loading when usecase is called', () {
//       // arrange
//       arrangeUsecase();
//       // act
//       bloc.fetch(tId);
//       // assert
//       expect(bloc.state.movieState, RequestState.loading);
//       expect(listenerCallCount, 0);
//     });

//     test('Should change when data is gotten successfully', () async {
//       // arrange
//       arrangeUsecase();
//       // act
//       await bloc.fetch(tId);
//       // assert
//       expect(bloc.state.movieState, RequestState.loaded);
//       expect(bloc.state.movie, testMovieDetail);
//       expect(listenerCallCount, 2);
//     });

//     test('Should change recommendation when data is gotten successfully',
//         () async {
//       // arrange
//       arrangeUsecase();
//       // act
//       await bloc.fetch(tId);
//       // assert
//       expect(bloc.state.movieState, RequestState.loaded);
//       expect(bloc.state.recommendations, tDummyList);
//     });
//   });

//   group('Get Recommendations Based On Current TV Show', () {
//     test('Should get data from the usecase', () async {
//       // arrange
//       arrangeUsecase();
//       // act
//       await bloc.fetch(tId);
//       // assert
//       verify(() => mockGetTvRecommendations(tId));
//       expect(bloc.state.recommendations, tDummyList);
//     });

//     test('Should update recommendation state when data is gotten successfully',
//         () async {
//       // arrange
//       arrangeUsecase();
//       // act
//       await bloc.fetch(tId);
//       // assert
//       expect(bloc.state.recommendationState, RequestState.loaded);
//       expect(bloc.state.recommendations, tDummyList);
//     });

//     test('Should update error message when request in successful', () async {
//       // arrange
//       when(() => mockGetTvDetail(tId))
//           .thenAnswer((_) async => const Right(testMovieDetail));
//       when(() => mockGetTvRecommendations(tId))
//           .thenAnswer((_) async => const Left(ServerFailure('Failed')));
//       // act
//       await bloc.fetch(tId);
//       // assert
//       expect(bloc.state.recommendationState, RequestState.error);
//       expect(bloc.state.message, 'Failed');
//     });
//   });

//   group('Watchlist', () {
//     test('Should get the watchlist status', () async {
//       // arrange
//       when(() => mockGetWatchlistStatus(1)).thenAnswer((_) async => true);
//       // act
//       await bloc.loadWatchlistStatus(1);
//       // assert
//       expect(bloc.state.isAddedToWatchlist, true);
//     });

//     test('Should execute save watchlist when function called', () async {
//       // arrange
//       const itemDetail = testMovieDetail;
//       final item = itemDetail.toMovie();
//       when(() => mockSaveWatchlist(item))
//           .thenAnswer((_) async => const Right('Success'));
//       when(() => mockGetWatchlistStatus(itemDetail.id))
//           .thenAnswer((_) async => true);
//       // act
//       await bloc.addWatchlist(itemDetail);
//       // assert
//       verify(() => mockSaveWatchlist(item));
//     });

//     test('Should execute remove watchlist when function called', () async {
//       // arrange
//       const itemDetail = testMovieDetail;
//       final item = itemDetail.toMovie();
//       when(() => mockRemoveWatchlist(item))
//           .thenAnswer((_) async => const Right('Removed'));
//       when(() => mockGetWatchlistStatus(itemDetail.id))
//           .thenAnswer((_) async => false);
//       // act
//       await bloc.removeFromWatchlist(itemDetail);
//       // assert
//       verify(() => mockRemoveWatchlist(item));
//     });

//     test('Should update watchlist status when add watchlist success', () async {
//       // arrange
//       const itemDetail = testMovieDetail;
//       final item = itemDetail.toMovie();
//       when(() => mockSaveWatchlist(item))
//           .thenAnswer((_) async => const Right('Added to Watchlist'));
//       when(() => mockGetWatchlistStatus(itemDetail.id))
//           .thenAnswer((_) async => true);
//       // act
//       await bloc.addWatchlist(itemDetail);
//       // assert
//       verify(() => mockGetWatchlistStatus(itemDetail.id));
//       expect(bloc.state.isAddedToWatchlist, true);
//       expect(bloc.state.watchlistMessage, 'Added to Watchlist');
//       expect(listenerCallCount, 1);
//     });

//     test('Should update watchlist message when add watchlist failed', () async {
//       // arrange
//       const itemDetail = testMovieDetail;
//       final item = itemDetail.toMovie();
//       when(() => mockSaveWatchlist(item))
//           .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
//       when(() => mockGetWatchlistStatus(itemDetail.id))
//           .thenAnswer((_) async => false);
//       // act
//       await bloc.addWatchlist(itemDetail);
//       // assert
//       expect(bloc.state.watchlistMessage, 'Failed');
//       expect(listenerCallCount, 1);
//     });
//   });

//   group('When Error Occur', () {
//     test('Should return error when data is unsuccessful', () async {
//       // arrange
//       when(() => mockGetTvDetail(tId))
//           .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
//       when(() => mockGetTvRecommendations(tId))
//           .thenAnswer((_) async => Right(tDummyList));
//       // act
//       await bloc.fetch(tId);
//       // assert
//       expect(bloc.state.movieState, RequestState.error);
//       expect(bloc.state.message, 'Server Failure');
//       expect(listenerCallCount, 2);
//     });
//   });
// }
