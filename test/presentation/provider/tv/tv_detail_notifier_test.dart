// import 'package:dicoding_ditonton/domain/enums/show_type.dart';
// import 'package:dicoding_ditonton/domain/usecases/tv/get_tv_detail.dart';
// import 'package:dicoding_ditonton/domain/usecases/tv/get_tv_recommendations.dart';
// import 'package:dicoding_ditonton/presentation/provider/tv/tv_detail_notifier.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:dicoding_ditonton/domain/entities/movie.dart';
// import 'package:dicoding_ditonton/common/failure.dart';
// import 'package:dicoding_ditonton/domain/usecases/watchlist/get_watchlist_status.dart';
// import 'package:dicoding_ditonton/domain/usecases/watchlist/remove_watchlist.dart';
// import 'package:dicoding_ditonton/domain/usecases/watchlist/save_watchlist.dart';
// import 'package:dicoding_ditonton/common/state_enum.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../../dummy_data/dummy_objects.dart';

// class MockGetTvDetail extends Mock implements GetTvDetail {}
// class MockGetTvRecommendations extends Mock implements GetTvRecommendations {}
// class MockGetWatchListStatus extends Mock implements GetWatchListStatus {}
// class MockSaveWatchlist extends Mock implements SaveWatchlist {}
// class MockRemoveWatchlist extends Mock implements RemoveWatchlist {}

// void main() {
//   late TvDetailNotifier provider;
//   late GetTvDetail mockGetTvDetail;
//   late GetTvRecommendations mockGetTvRecommendations;
//   late GetWatchListStatus mockGetWatchlistStatus;
//   late SaveWatchlist mockSaveWatchlist;
//   late RemoveWatchlist mockRemoveWatchlist;
//   late int listenerCallCount;

//   setUp(() {
//     listenerCallCount = 0;
//     mockGetTvDetail = MockGetTvDetail();
//     mockGetTvRecommendations = MockGetTvRecommendations();
//     mockGetWatchlistStatus = MockGetWatchListStatus();
//     mockSaveWatchlist = MockSaveWatchlist();
//     mockRemoveWatchlist = MockRemoveWatchlist();
//     provider = TvDetailNotifier(
//       getTvDetail: mockGetTvDetail,
//       getTvRecommendations: mockGetTvRecommendations,
//       getWatchListStatus: mockGetWatchlistStatus,
//       saveWatchlist: mockSaveWatchlist,
//       removeWatchlist: mockRemoveWatchlist,
//     )..addListener(() {
//         listenerCallCount += 1;
//       });
//   });

//   const tId = 1;

//   const tMovie = Movie(
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
//   final tMovies = <Movie>[tMovie];

//   void arrangeUsecase() {
//     when(() => mockGetTvDetail(tId))
//         .thenAnswer((_) async => const Right(testMovieDetail));
//     when(() => mockGetTvRecommendations(tId))
//         .thenAnswer((_) async => Right(tMovies));
//   }

//   group('Get TV Show Detail', () {
//     test('Should get data from the usecase', () async {
//       // arrange
//       arrangeUsecase();
//       // act
//       await provider.fetchDetail(tId);
//       // assert
//       verify(() => mockGetTvDetail(tId));
//       verify(() => mockGetTvRecommendations(tId));
//     });

//     test('Should change state to Loading when usecase is called', () {
//       // arrange
//       arrangeUsecase();
//       // act
//       provider.fetchDetail(tId);
//       // assert
//       expect(provider.movieState, RequestState.loading);
//       expect(listenerCallCount, 1);
//     });

//     test('Should change when data is gotten successfully', () async {
//       // arrange
//       arrangeUsecase();
//       // act
//       await provider.fetchDetail(tId);
//       // assert
//       expect(provider.movieState, RequestState.loaded);
//       expect(provider.movie, testMovieDetail);
//       expect(listenerCallCount, 3);
//     });

//     test('Should change recommendation when data is gotten successfully',
//         () async {
//       // arrange
//       arrangeUsecase();
//       // act
//       await provider.fetchDetail(tId);
//       // assert
//       expect(provider.movieState, RequestState.loaded);
//       expect(provider.movieRecommendations, tMovies);
//     });
//   });

//   group('Get Recommendations Based On Current TV Show', () {
//     test('Should get data from the usecase', () async {
//       // arrange
//       arrangeUsecase();
//       // act
//       await provider.fetchDetail(tId);
//       // assert
//       verify(() => mockGetTvRecommendations(tId));
//       expect(provider.movieRecommendations, tMovies);
//     });

//     test('Should update recommendation state when data is gotten successfully',
//         () async {
//       // arrange
//       arrangeUsecase();
//       // act
//       await provider.fetchDetail(tId);
//       // assert
//       expect(provider.recommendationState, RequestState.loaded);
//       expect(provider.movieRecommendations, tMovies);
//     });

//     test('Should update error message when request in successful', () async {
//       // arrange
//       when(() => mockGetTvDetail(tId))
//           .thenAnswer((_) async => const Right(testMovieDetail));
//       when(() => mockGetTvRecommendations(tId))
//           .thenAnswer((_) async => const Left(ServerFailure('Failed')));
//       // act
//       await provider.fetchDetail(tId);
//       // assert
//       expect(provider.recommendationState, RequestState.error);
//       expect(provider.message, 'Failed');
//     });
//   });

//   group('Watchlist', () {
//     test('Should get the watchlist status', () async {
//       // arrange
//       when(() => mockGetWatchlistStatus(1)).thenAnswer((_) async => true);
//       // act
//       await provider.loadWatchlistStatus(1);
//       // assert
//       expect(provider.isAddedToWatchlist, true);
//     });

//     test('Should execute save watchlist when function called', () async {
//       // arrange
//       when(() => mockSaveWatchlist(tMovie))
//           .thenAnswer((_) async => const Right('Success'));
//       when(() => mockGetWatchlistStatus(testMovieDetail.id))
//           .thenAnswer((_) async => true);
//       // act
//       await provider.addWatchlist(tMovie);
//       // assert
//       verify(() => mockSaveWatchlist(tMovie));
//     });

//     test('Should execute remove watchlist when function called', () async {
//       // arrange
//       when(() => mockRemoveWatchlist(tMovie))
//           .thenAnswer((_) async => const Right('Removed'));
//       when(() => mockGetWatchlistStatus(testMovieDetail.id))
//           .thenAnswer((_) async => false);
//       // act
//       await provider.removeFromWatchlist(tMovie);
//       // assert
//       verify(() => mockRemoveWatchlist(tMovie));
//     });

//     test('Should update watchlist status when add watchlist success', () async {
//       // arrange
//       when(() => mockSaveWatchlist(tMovie))
//           .thenAnswer((_) async => const Right('Added to Watchlist'));
//       when(() => mockGetWatchlistStatus(testMovieDetail.id))
//           .thenAnswer((_) async => true);
//       // act
//       await provider.addWatchlist(tMovie);
//       // assert
//       verify(() => mockGetWatchlistStatus(testMovieDetail.id));
//       expect(provider.isAddedToWatchlist, true);
//       expect(provider.watchlistMessage, 'Added to Watchlist');
//       expect(listenerCallCount, 1);
//     });

//     test('Should update watchlist message when add watchlist failed', () async {
//       // arrange
//       when(() => mockSaveWatchlist(tMovie))
//           .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
//       when(() => mockGetWatchlistStatus(testMovieDetail.id))
//           .thenAnswer((_) async => false);
//       // act
//       await provider.addWatchlist(tMovie);
//       // assert
//       expect(provider.watchlistMessage, 'Failed');
//       expect(listenerCallCount, 1);
//     });
//   });

//   group('When Error Occur', () {
//     test('Should return error when data is unsuccessful', () async {
//       // arrange
//       when(() => mockGetTvDetail(tId))
//           .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
//       when(() => mockGetTvRecommendations(tId))
//           .thenAnswer((_) async => Right(tMovies));
//       // act
//       await provider.fetchDetail(tId);
//       // assert
//       expect(provider.movieState, RequestState.error);
//       expect(provider.message, 'Server Failure');
//       expect(listenerCallCount, 2);
//     });
//   });
// }
