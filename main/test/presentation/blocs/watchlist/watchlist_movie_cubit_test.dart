// import 'package:flutter_test/flutter_test.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:mocktail/mocktail.dart';

// import 'package:core/core.dart';
// import 'package:dicoding_ditonton/domain/usecases/movie/get_watchlist_movies.dart';
// import 'package:dicoding_ditonton/presentation/blocs/watchlist/watchlist_movie_cubit.dart';

// import '../../../dummy_data/dummy_objects.dart';

// class MockGetWatchlistMovies extends Mock implements GetWatchlistMovies {}

// void main() {
//   late WatchlistMovieCubit bloc;
//   late GetWatchlistMovies mockGetWatchlistMovies;
//   late int listenerCallCount;

//   setUp(() {
//     listenerCallCount = 0;
//     mockGetWatchlistMovies = MockGetWatchlistMovies();
//     bloc = WatchlistMovieCubit(
//       getWatchlistMovies: mockGetWatchlistMovies,
//     );
//     bloc.stream.listen((_) {
//       listenerCallCount++;
//     });
//   });

//   test('Should change movies data when data is gotten successfully', () async {
//     // arrange
//     when(() => mockGetWatchlistMovies())
//         .thenAnswer((_) async => const Right([testWatchlistMovie]));
//     // act
//     await bloc.fetch();
//     // assert
//     expect(bloc.state.state, RequestState.loaded);
//     expect(bloc.state.movies, [testWatchlistMovie]);
//     expect(listenerCallCount, 1);
//   });

//   test('Should return error when data is unsuccessful', () async {
//     // arrange
//     when(() => mockGetWatchlistMovies())
//         .thenAnswer((_) async => const Left(DatabaseFailure("Can't get data")));
//     // act
//     await bloc.fetch();
//     // assert
//     expect(bloc.state.state, RequestState.error);
//     expect(bloc.state.message, "Can't get data");
//     expect(listenerCallCount, 1);
//   });
// }
