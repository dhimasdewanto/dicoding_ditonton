import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:watchlist/presentation/blocs/watchlist_list_cubit.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetWatchlistMovies extends Mock implements GetWatchlistItems {}

void main() {
  late WatchlistCubit bloc;
  late GetWatchlistItems mockGetWatchlistItems;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistItems = MockGetWatchlistMovies();
    bloc = WatchlistCubit(
      getWatchlistItems: mockGetWatchlistItems,
    );
    bloc.stream.listen((_) {
      listenerCallCount++;
    });
  });

  test('Should change movies data when data is gotten successfully', () async {
    // arrange
    when(() => mockGetWatchlistItems())
        .thenAnswer((_) async => const Right(testList));
    // act
    await bloc.fetch();
    // assert
    expect(bloc.state.state, RequestState.loaded);
    expect(bloc.state.movies, testList);
    expect(listenerCallCount, 1);
  });

  test('Should return error when data is unsuccessful', () async {
    // arrange
    when(() => mockGetWatchlistItems())
        .thenAnswer((_) async => const Left(DatabaseFailure("Can't get data")));
    // act
    await bloc.fetch();
    // assert
    expect(bloc.state.state, RequestState.error);
    expect(bloc.state.message, "Can't get data");
    expect(listenerCallCount, 1);
  });
}
