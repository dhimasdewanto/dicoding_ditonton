import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:core/core.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/presentation/blocs/tv_detail_cubit.dart';
import 'package:tv_show/presentation/pages/tv_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvDetailCubit extends MockCubit<TvDetailState>
    implements TvDetailCubit {}

void main() {
  late TvDetailCubit mockBloc;

  setUp(() {
    mockBloc = MockTvDetailCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailCubit>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (tester) async {
    when(() => mockBloc.fetch(1)).thenAnswer((_) async {});
    when(() => mockBloc.loadWatchlistStatus(1)).thenAnswer((_) async {});
    whenListen<TvDetailState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const TvDetailState(
        movieState: RequestState.loaded,
        tvShow: testDetail,
        recommendationState: RequestState.loaded,
        recommendations: <TvShow>[],
        isAddedToWatchlist: false,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (tester) async {
    when(() => mockBloc.fetch(1)).thenAnswer((_) async {});
    when(() => mockBloc.loadWatchlistStatus(1)).thenAnswer((_) async {});
    whenListen<TvDetailState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const TvDetailState(
        movieState: RequestState.loaded,
        tvShow: testDetail,
        recommendationState: RequestState.loaded,
        recommendations: <TvShow>[],
        isAddedToWatchlist: true,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (tester) async {
    when(() => mockBloc.fetch(1)).thenAnswer((_) async {});
    when(() => mockBloc.loadWatchlistStatus(1)).thenAnswer((_) async {});
    when(() => mockBloc.addWatchlist(testItem)).thenAnswer((_) async {});
    when(() => mockBloc.removeFromWatchlist(testItem))
        .thenAnswer((_) async {});
    whenListen<TvDetailState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const TvDetailState(
        movieState: RequestState.loaded,
        tvShow: testDetail,
        recommendationState: RequestState.loaded,
        recommendations: <TvShow>[],
        isAddedToWatchlist: false,
        message: 'Added to Watchlist',
      ),
    );
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (tester) async {
    when(() => mockBloc.fetch(1)).thenAnswer((_) async {});
    when(() => mockBloc.loadWatchlistStatus(1)).thenAnswer((_) async {});
    when(() => mockBloc.addWatchlist(testItem)).thenAnswer((_) async {});
    when(() => mockBloc.removeFromWatchlist(testItem))
        .thenAnswer((_) async {});
    whenListen<TvDetailState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const TvDetailState(
        movieState: RequestState.loaded,
        tvShow: testDetail,
        recommendationState: RequestState.loaded,
        recommendations: <TvShow>[],
        isAddedToWatchlist: false,
        message: 'Failed',
      ),
    );
  });
}
