import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:core/core.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/presentation/blocs/movie/movie_detail_cubit.dart';
import 'package:dicoding_ditonton/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailCubit extends MockCubit<MovieDetailState>
    implements MovieDetailCubit {}

void main() {
  late MovieDetailCubit mockBloc;

  setUp(() {
    mockBloc = MockMovieDetailCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailCubit>.value(
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
    whenListen<MovieDetailState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const MovieDetailState(
        movieState: RequestState.loaded,
        movie: testMovieDetail,
        recommendationState: RequestState.loaded,
        recommendations: <Movie>[],
        isAddedToWatchlist: false,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (tester) async {
    when(() => mockBloc.fetch(1)).thenAnswer((_) async {});
    when(() => mockBloc.loadWatchlistStatus(1)).thenAnswer((_) async {});
    whenListen<MovieDetailState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const MovieDetailState(
        movieState: RequestState.loaded,
        movie: testMovieDetail,
        recommendationState: RequestState.loaded,
        recommendations: <Movie>[],
        isAddedToWatchlist: true,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (tester) async {
    when(() => mockBloc.fetch(1)).thenAnswer((_) async {});
    when(() => mockBloc.loadWatchlistStatus(1)).thenAnswer((_) async {});
    when(() => mockBloc.addWatchlist(testMovieDetail)).thenAnswer((_) async {});
    when(() => mockBloc.removeFromWatchlist(testMovieDetail))
        .thenAnswer((_) async {});
    whenListen<MovieDetailState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const MovieDetailState(
        movieState: RequestState.loaded,
        movie: testMovieDetail,
        recommendationState: RequestState.loaded,
        recommendations: <Movie>[],
        isAddedToWatchlist: false,
        message: 'Added to Watchlist',
      ),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (tester) async {
    when(() => mockBloc.fetch(1)).thenAnswer((_) async {});
    when(() => mockBloc.loadWatchlistStatus(1)).thenAnswer((_) async {});
    when(() => mockBloc.addWatchlist(testMovieDetail)).thenAnswer((_) async {});
    when(() => mockBloc.removeFromWatchlist(testMovieDetail))
        .thenAnswer((_) async {});
    whenListen<MovieDetailState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const MovieDetailState(
        movieState: RequestState.loaded,
        movie: testMovieDetail,
        recommendationState: RequestState.loaded,
        recommendations: <Movie>[],
        isAddedToWatchlist: false,
        message: 'Failed',
      ),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
