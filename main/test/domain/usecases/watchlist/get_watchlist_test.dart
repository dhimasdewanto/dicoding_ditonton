// import 'package:dicoding_ditonton/domain/repositories/watchlist_repository.dart';
// import 'package:dicoding_ditonton/domain/usecases/watchlist/get_watchlist.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../../dummy_data/dummy_objects.dart';
// import '../../../helpers/test_helper.dart';

// void main() {
//   late GetWatchlist usecase;
//   late WatchlistRepository repo;

//   setUp(() {
//     repo = MockWatchlistRepository();
//     usecase = GetWatchlist(repo: repo);
//   });

//   test('Should get list of watchlist from the repository', () async {
//     // arrange
//     when(() => repo.getList())
//         .thenAnswer((_) async => Right(testMovieList));
//     // act
//     final result = await usecase();
//     // assert
//     expect(result, Right(testMovieList));
//   });
// }
