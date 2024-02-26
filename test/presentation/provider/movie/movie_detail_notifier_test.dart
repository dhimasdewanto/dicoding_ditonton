// import 'package:dicoding_ditonton/domain/enums/show_type.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:dicoding_ditonton/domain/entities/movie.dart';
// import 'package:dicoding_ditonton/domain/usecases/movie/get_movie_detail.dart';
// import 'package:dicoding_ditonton/domain/usecases/movie/get_movie_recommendations.dart';
// import 'package:dicoding_ditonton/common/failure.dart';
// import 'package:dicoding_ditonton/domain/usecases/movie/get_watchlist_status.dart';
// import 'package:dicoding_ditonton/domain/usecases/movie/remove_watchlist.dart';
// import 'package:dicoding_ditonton/domain/usecases/movie/save_watchlist.dart';
// import 'package:dicoding_ditonton/presentation/provider/movie/movie_detail_notifier.dart';
// import 'package:dicoding_ditonton/common/state_enum.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../../dummy_data/dummy_objects.dart';

// class MockV2GetMovieDetail extends Mock implements GetMovieDetail {}
// class MockV2GetMovieRecommendations extends Mock implements GetMovieRecommendations {}
// class MockV2GetWatchListStatus extends Mock implements GetWatchListStatus {}
// class MockV2SaveWatchlist extends Mock implements SaveWatchlist {}
// class MockV2RemoveWatchlist extends Mock implements RemoveWatchlist {}

// void main() {
//   late MovieDetailNotifier provider;
//   late GetMovieDetail mockGetMovieDetail;
//   late GetMovieRecommendations mockGetMovieRecommendations;
//   late GetWatchListStatus mockGetWatchlistStatus;
//   late SaveWatchlist mockSaveWatchlist;
//   late RemoveWatchlist mockRemoveWatchlist;
//   late int listenerCallCount;

//   setUp(() {
//     listenerCallCount = 0;
//     mockGetMovieDetail = MockV2GetMovieDetail();
//     mockGetMovieRecommendations = MockV2GetMovieRecommendations();
//     mockGetWatchlistStatus = MockV2GetWatchListStatus();
//     mockSaveWatchlist = MockV2SaveWatchlist();
//     mockRemoveWatchlist = MockV2RemoveWatchlist();
//     provider = MovieDetailNotifier(
//       getMovieDetail: mockGetMovieDetail,
//       getMovieRecommendations: mockGetMovieRecommendations,
//       getWatchListStatus: mockGetWatchlistStatus,
//       saveWatchlist: mockSaveWatchlist,
//       removeWatchlist: mockRemoveWatchlist,
//     )..addListener(() {
//         listenerCallCount += 1;
//       });
//   });

//   const tId = 1;

//   const tMovie = Movie(
//     type: ShowType.movie,
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
//     when(() => mockGetMovieDetail(tId))
//         .thenAnswer((_) async => const Right(testMovieDetail));
//     when(() => mockGetMovieRecommendations(tId))
//         .thenAnswer((_) async => Right(tMovies));
//   }

//   group('Get Movie Detail', () {
//     test('should get data from the usecase', () async {
//       // arrange
//       arrangeUsecase();
//       // act
//       await provider.fetchMovieDetail(tId);
//       // assert
//       verify(() => mockGetMovieDetail(tId));
//       verify(() => mockGetMovieRecommendations(tId));
//     });

//     test('should change state to Loading when usecase is called', () {
//       // arrange
//       arrangeUsecase();
//       // act
//       provider.fetchMovieDetail(tId);
//       // assert
//       expect(provider.movieState, RequestState.loading);
//       expect(listenerCallCount, 1);
//     });

//     test('should change movie when data is gotten successfully', () async {
//       // arrange
//       arrangeUsecase();
//       // act
//       await provider.fetchMovieDetail(tId);
//       // assert
//       expect(provider.movieState, RequestState.loaded);
//       expect(provider.movie, testMovieDetail);
//       expect(listenerCallCount, 3);
//     });

//     test('should change recommendation movies when data is gotten successfully',
//         () async {
//       // arrange
//       arrangeUsecase();
//       // act
//       await provider.fetchMovieDetail(tId);
//       // assert
//       expect(provider.movieState, RequestState.loaded);
//       expect(provider.movieRecommendations, tMovies);
//     });
//   });

//   group('Get Movie Recommendations', () {
//     test('should get data from the usecase', () async {
//       // arrange
//       arrangeUsecase();
//       // act
//       await provider.fetchMovieDetail(tId);
//       // assert
//       verify(() => mockGetMovieRecommendations(tId));
//       expect(provider.movieRecommendations, tMovies);
//     });

//     test('should update recommendation state when data is gotten successfully',
//         () async {
//       // arrange
//       arrangeUsecase();
//       // act
//       await provider.fetchMovieDetail(tId);
//       // assert
//       expect(provider.recommendationState, RequestState.loaded);
//       expect(provider.movieRecommendations, tMovies);
//     });

//     test('should update error message when request in successful', () async {
//       // arrange
//       when(() => mockGetMovieDetail(tId))
//           .thenAnswer((_) async => const Right(testMovieDetail));
//       when(() => mockGetMovieRecommendations(tId))
//           .thenAnswer((_) async => const Left(ServerFailure('Failed')));
//       // act
//       await provider.fetchMovieDetail(tId);
//       // assert
//       expect(provider.recommendationState, RequestState.error);
//       expect(provider.message, 'Failed');
//     });
//   });

//   group('Watchlist', () {
//     test('should get the watchlist status', () async {
//       // arrange
//       when(() => mockGetWatchlistStatus(1)).thenAnswer((_) async => true);
//       // act
//       await provider.loadWatchlistStatus(1);
//       // assert
//       expect(provider.isAddedToWatchlist, true);
//     });

//     test('should execute save watchlist when function called', () async {
//       // arrange
//       when(() => mockSaveWatchlist(testMovieDetail))
//           .thenAnswer((_) async => const Right('Success'));
//       when(() => mockGetWatchlistStatus(testMovieDetail.id))
//           .thenAnswer((_) async => true);
//       // act
//       await provider.addWatchlist(testMovieDetail);
//       // assert
//       verify(() => mockSaveWatchlist(testMovieDetail));
//     });

//     test('should execute remove watchlist when function called', () async {
//       // arrange
//       when(() => mockRemoveWatchlist(testMovieDetail))
//           .thenAnswer((_) async => const Right('Removed'));
//       when(() => mockGetWatchlistStatus(testMovieDetail.id))
//           .thenAnswer((_) async => false);
//       // act
//       await provider.removeFromWatchlist(testMovieDetail);
//       // assert
//       verify(() => mockRemoveWatchlist(testMovieDetail));
//     });

//     test('should update watchlist status when add watchlist success', () async {
//       // arrange
//       when(() => mockSaveWatchlist(testMovieDetail))
//           .thenAnswer((_) async => const Right('Added to Watchlist'));
//       when(() => mockGetWatchlistStatus(testMovieDetail.id))
//           .thenAnswer((_) async => true);
//       // act
//       await provider.addWatchlist(testMovieDetail);
//       // assert
//       verify(() => mockGetWatchlistStatus(testMovieDetail.id));
//       expect(provider.isAddedToWatchlist, true);
//       expect(provider.watchlistMessage, 'Added to Watchlist');
//       expect(listenerCallCount, 1);
//     });

//     test('should update watchlist message when add watchlist failed', () async {
//       // arrange
//       when(() => mockSaveWatchlist(testMovieDetail))
//           .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
//       when(() => mockGetWatchlistStatus(testMovieDetail.id))
//           .thenAnswer((_) async => false);
//       // act
//       await provider.addWatchlist(testMovieDetail);
//       // assert
//       expect(provider.watchlistMessage, 'Failed');
//       expect(listenerCallCount, 1);
//     });
//   });

//   group('on Error', () {
//     test('should return error when data is unsuccessful', () async {
//       // arrange
//       when(() => mockGetMovieDetail(tId))
//           .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
//       when(() => mockGetMovieRecommendations(tId))
//           .thenAnswer((_) async => Right(tMovies));
//       // act
//       await provider.fetchMovieDetail(tId);
//       // assert
//       expect(provider.movieState, RequestState.error);
//       expect(provider.message, 'Server Failure');
//       expect(listenerCallCount, 2);
//     });
//   });
// }
