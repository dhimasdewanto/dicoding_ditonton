import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:watchlist/presentation/blocs/watchlist_list_cubit.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';

class MockOnTheAirTvCubit extends MockCubit<WatchlistState> implements WatchlistCubit {}

void main() {
  late WatchlistCubit mockBloc;

  setUp(() {
    mockBloc = MockOnTheAirTvCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistCubit>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.fetch()).thenAnswer((_) async {});
    whenListen<WatchlistState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const WatchlistState(state: RequestState.loading),
    );

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const WatchlistListPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded and empty',
      (WidgetTester tester) async {
    when(() => mockBloc.fetch()).thenAnswer((_) async {});
    whenListen<WatchlistState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const WatchlistState(
        state: RequestState.loaded,
        movies: <Watchlist>[],
      ),
    );

    final findCenter = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const WatchlistListPage()));

    expect(findCenter, findsOneWidget);
    expect(find.text("Watchlist is Empty"), findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.fetch()).thenAnswer((_) async {});
    whenListen<WatchlistState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const WatchlistState(
        state: RequestState.loaded,
        movies: testList,
      ),
    );

    final findListView = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const WatchlistListPage()));

    expect(findListView, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.fetch()).thenAnswer((_) async {});
    whenListen<WatchlistState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const WatchlistState(
        state:RequestState.error,
        message: 'Error message',
      ),
    );

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const WatchlistListPage()));

    expect(textFinder, findsOneWidget);
  });
}
