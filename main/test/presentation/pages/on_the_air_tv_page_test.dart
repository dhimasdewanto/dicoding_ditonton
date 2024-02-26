import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:core/core.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/presentation/blocs/tv/on_the_air_tv_cubit.dart';
import 'package:dicoding_ditonton/presentation/pages/on_the_air_tv_page.dart';

class MockOnTheAirTvCubit extends MockCubit<OnTheAirTvState> implements OnTheAirTvCubit {}

void main() {
  late OnTheAirTvCubit mockBloc;

  setUp(() {
    mockBloc = MockOnTheAirTvCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<OnTheAirTvCubit>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.fetch()).thenAnswer((_) async {});
    whenListen<OnTheAirTvState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const OnTheAirTvState(state: RequestState.loading),
    );

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const OnTheAirTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.fetch()).thenAnswer((_) async {});
    whenListen<OnTheAirTvState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const OnTheAirTvState(
        state: RequestState.loaded,
        movies: <Movie>[],
      ),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const OnTheAirTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.fetch()).thenAnswer((_) async {});
    whenListen<OnTheAirTvState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const OnTheAirTvState(
        state:RequestState.error,
        message: 'Error message',
      ),
    );

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const OnTheAirTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
