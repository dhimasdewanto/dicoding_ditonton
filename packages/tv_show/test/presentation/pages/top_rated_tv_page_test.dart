import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:core/core.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/presentation/blocs/top_rated_tv_cubit.dart';
import 'package:tv_show/presentation/pages/top_rated_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedTvCubit extends MockCubit<TopRatedTvState>
    implements TopRatedTvCubit {}

void main() {
  late TopRatedTvCubit mockBloc;

  setUp(() {
    mockBloc = MockTopRatedTvCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvCubit>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading', (tester) async {
    when(() => mockBloc.fetch()).thenAnswer((_) async {});
    whenListen<TopRatedTvState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const TopRatedTvState(state: RequestState.loading),
    );

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded', (tester) async {
    when(() => mockBloc.fetch()).thenAnswer((_) async {});
    whenListen<TopRatedTvState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const TopRatedTvState(
        state: RequestState.loaded,
        shows: <TvShow>[testItem],
      ),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (tester) async {
    when(() => mockBloc.fetch()).thenAnswer((_) async {});
    whenListen<TopRatedTvState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const TopRatedTvState(
        state:RequestState.error,
        message: 'Error message',
      ),
    );

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
