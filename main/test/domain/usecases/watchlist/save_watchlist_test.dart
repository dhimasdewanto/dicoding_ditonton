// import 'package:dicoding_ditonton/domain/repositories/watchlist_repository.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:dicoding_ditonton/domain/usecases/watchlist/save_watchlist.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../../dummy_data/dummy_objects.dart';
// import '../../../helpers/test_helper.dart';

// void main() {
//   late SaveWatchlist usecase;
//   late WatchlistRepository repo;

//   setUp(() {
//     repo = MockWatchlistRepository();
//     usecase = SaveWatchlist(repo: repo);
//   });

//   test('Should save watchlist to the repository', () async {
//     // arrange
//     when(() => repo.save(testMovie2))
//         .thenAnswer((_) async => const Right('Added to Watchlist'));
//     // act
//     final result = await usecase(testMovie2);
//     // assert
//     verify(() => repo.save(testMovie2));
//     expect(result, const Right('Added to Watchlist'));
//   });
// }
