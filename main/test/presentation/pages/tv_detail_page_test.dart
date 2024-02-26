import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:core/core.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/presentation/blocs/tv/tv_detail_cubit.dart';
import 'package:dicoding_ditonton/presentation/pages/tv_detail_page.dart';

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
        movie: testTvDetail,
        recommendationState: RequestState.loaded,
        recommendations: <Movie>[],
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
        movie: testTvDetail,
        recommendationState: RequestState.loaded,
        recommendations: <Movie>[],
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
    when(() => mockBloc.addWatchlist(testTvDetail)).thenAnswer((_) async {});
    when(() => mockBloc.removeFromWatchlist(testTvDetail))
        .thenAnswer((_) async {});
    whenListen<TvDetailState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const TvDetailState(
        movieState: RequestState.loaded,
        movie: testTvDetail,
        recommendationState: RequestState.loaded,
        recommendations: <Movie>[],
        isAddedToWatchlist: false,
        message: 'Added to Watchlist',
      ),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (tester) async {
    when(() => mockBloc.fetch(1)).thenAnswer((_) async {});
    when(() => mockBloc.loadWatchlistStatus(1)).thenAnswer((_) async {});
    when(() => mockBloc.addWatchlist(testTvDetail)).thenAnswer((_) async {});
    when(() => mockBloc.removeFromWatchlist(testTvDetail))
        .thenAnswer((_) async {});
    whenListen<TvDetailState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const TvDetailState(
        movieState: RequestState.loaded,
        movie: testTvDetail,
        recommendationState: RequestState.loaded,
        recommendations: <Movie>[],
        isAddedToWatchlist: false,
        message: 'Failed',
      ),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
