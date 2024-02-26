import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/presentation/blocs/movie/top_rated_movies_cubit.dart';
import 'package:dicoding_ditonton/presentation/pages/top_rated_movies_page.dart';

class MockTopRatedMoviesCubit extends MockCubit<TopRatedMoviesState>
    implements TopRatedMoviesCubit {}

void main() {
  late TopRatedMoviesCubit mockBloc;

  setUp(() {
    mockBloc = MockTopRatedMoviesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesCubit>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading', (tester) async {
    when(() => mockBloc.fetch()).thenAnswer((_) async {});
    whenListen<TopRatedMoviesState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const TopRatedMoviesState(state: RequestState.loading),
    );

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded', (tester) async {
    when(() => mockBloc.fetch()).thenAnswer((_) async {});
    whenListen<TopRatedMoviesState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const TopRatedMoviesState(
        state: RequestState.loaded,
        movies: <Movie>[],
      ),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (tester) async {
    when(() => mockBloc.fetch()).thenAnswer((_) async {});
    whenListen<TopRatedMoviesState>(
      mockBloc,
      Stream.fromIterable([]),
      initialState: const TopRatedMoviesState(
        state:RequestState.error,
        message: 'Error message',
      ),
    );

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
