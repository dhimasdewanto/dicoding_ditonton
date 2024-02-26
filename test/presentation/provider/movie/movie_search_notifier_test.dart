// import 'package:dicoding_ditonton/domain/enums/show_type.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:dicoding_ditonton/common/failure.dart';
// import 'package:dicoding_ditonton/common/state_enum.dart';
// import 'package:dicoding_ditonton/domain/entities/movie.dart';
// import 'package:dicoding_ditonton/domain/usecases/movie/search_movies.dart';
// import 'package:dicoding_ditonton/presentation/provider/movie/movie_search_notifier.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockSearchMovies extends Mock implements SearchMovies {}

// void main() {
//   late MovieSearchNotifier provider;
//   late SearchMovies mockSearchMovies;
//   late int listenerCallCount;

//   setUp(() {
//     listenerCallCount = 0;
//     mockSearchMovies = MockSearchMovies();
//     provider = MovieSearchNotifier(searchMovies: mockSearchMovies)
//       ..addListener(() {
//         listenerCallCount += 1;
//       });
//   });

//   const tMovieModel = Movie(
//     type: ShowType.movie,
//     adult: false,
//     backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
//     genreIds: [14, 28],
//     id: 557,
//     originalTitle: 'Spider-Man',
//     overview:
//         'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
//     popularity: 60.441,
//     posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
//     releaseDate: '2002-05-01',
//     title: 'Spider-Man',
//     voteAverage: 7.2,
//     voteCount: 13507,
//   );
//   final tMovieList = <Movie>[tMovieModel];
//   const tQuery = 'spiderman';

//   group('search movies', () {
//     test('should change state to loading when usecase is called', () async {
//       // arrange
//       when(() => mockSearchMovies(tQuery))
//           .thenAnswer((_) async => Right(tMovieList));
//       // act
//       provider.fetchMovieSearch(tQuery);
//       // assert
//       expect(provider.state, RequestState.loading);
//     });

//     test('should change search result data when data is gotten successfully',
//         () async {
//       // arrange
//       when(() => mockSearchMovies(tQuery))
//           .thenAnswer((_) async => Right(tMovieList));
//       // act
//       await provider.fetchMovieSearch(tQuery);
//       // assert
//       expect(provider.state, RequestState.loaded);
//       expect(provider.searchResult, tMovieList);
//       expect(listenerCallCount, 2);
//     });

//     test('should return error when data is unsuccessful', () async {
//       // arrange
//       when(() => mockSearchMovies(tQuery))
//           .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
//       // act
//       await provider.fetchMovieSearch(tQuery);
//       // assert
//       expect(provider.state, RequestState.error);
//       expect(provider.message, 'Server Failure');
//       expect(listenerCallCount, 2);
//     });
//   });
// }
